// ignore_for_file: file_names

import 'dart:async';
import 'package:birthday_app_new/Views/localnotifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import '../Database/DBHelper.dart';

Future<void> initializeService(bool isbackground) async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: isbackground,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: isbackground,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
  return true;
}

void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    var now = DateTime.now();
    List<dynamic> reminders = await DBHelper().getreminder();
    for (var item in reminders) {
      var now = DateTime.now();
      var day = now.day < 10 ? "0${now.day}" : now.day.toString();
      var month = now.month < 10 ? "0${now.month}" : now.month.toString();
       var date = "${now.year}-$month-$day";
   //  var date = "${now.day}/${now.month}/${now.year}";
      var minute = now.minute < 10 ? "0${now.minute}" : now.minute.toString();
      var time = "${now.hour}:$minute";
      //var time = "${now.hour}:${now.minute}";
      if (item['rdate'] == date && item["rtime"] == time) {
        BCMNotification.notify(
            "Birthday Reminder", item['r_title'].toString(), "basic_channel");
      }
    }









    
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Birthday Card Maker",
        content: "Updated at ${DateTime.now()}",
      );
    }
    // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    // final deviceInfo = DeviceInfoPlugin();
    // String? device;
    // if (Platform.isAndroid) {
    //   final androidInfo = await deviceInfo.androidInfo;
    //   device = androidInfo.model;
    //   print(device);
    // }
    // if (Platform.isIOS) {
    //   final iosInfo = await deviceInfo.iosInfo;
    //   device = iosInfo.model;
    // }
    // service.invoke(
    //   'update',
    //   {
    //     "current_date": DateTime.now().toIso8601String(),
    //     "device": device,
    //   },
    // );
  });
}
