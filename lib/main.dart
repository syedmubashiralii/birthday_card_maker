import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:birthday_app_new/Views/TimerService.dart';
import 'Controller/AdsController.dart';
import 'package:birthday_app_new/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'BLoC/application_bloc.dart';
import 'Services/connectivity_service.dart';
import 'Views/BackgroundService.dart';
import 'Views/LandingPage.dart';
import 'enums/connectivity_status.dart';

// const IAdIdManager adIdManager = AdController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimerService();
   initializeService(true);
  MobileAds.instance.initialize();
  try {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: "basic_channel",
              channelName: "Basic Channel",
              channelDescription: "Channel for send alert to users",
              enableVibration: true,
              importance: NotificationImportance.High,
              channelShowBadge: true),
          NotificationChannel(
              channelGroupKey: 'category_tests',
              channelKey: 'alarm_channel',
              channelName: 'Alarms Channel',
              channelDescription: 'Channel with alarm ringtone',
              importance: NotificationImportance.Max,
              ledColor: Colors.black,
              enableLights: true,
              enableVibration: true,
              channelShowBadge: true,
              locked: false,
              defaultRingtoneType: DefaultRingtoneType.Alarm),
        ],
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // BCMNotification.listenBCMNotification();
  } catch (ex) {
    print(ex);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.foldingCube
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 35.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = ApplicationBloc();
    LanguageController language = LanguageController();
    get_ads ad = get_ads();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => applicationBloc),
          ),
          ChangeNotifierProvider(
            create: ((context) => language),
          ),
          ChangeNotifierProvider(
            create: ((context) => ad),
          ),
          StreamProvider<ConnectivityStatus>(
            initialData: ConnectivityStatus.WiFi,
            create: (context) =>
                ConnectivityService().connectionStatusController.stream,
          )
        ],
        child: GetMaterialApp(
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          title: 'BirthDay Card Maker',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xffF9F3D7),
            fontFamily: 'BalooM',
          ),
          home: const LandingPage(),
          builder: EasyLoading.init(),
        ));
  }
}
