import 'dart:io';
import 'package:birthday_app_new/Ads/openads.dart';
import 'package:birthday_app_new/Views/BirthdaySongs/audio_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../Controller/AdsController.dart';
import '../../Widgets/widgets.dart';

class Musicpayer extends StatefulWidget {
  String name;
  String audiourl;
  String thumbnail;
  Musicpayer(
      {Key? key,
      required this.name,
      required this.audiourl,
      required this.thumbnail})
      : super(key: key);

  @override
  State<Musicpayer> createState() => _MusicpayerState();
}

class _MusicpayerState extends State<Musicpayer> with WidgetsBindingObserver {
  bool isrunning = false;
  bool issharebutton = false;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  late final PageManager _pageManager;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
    WidgetsBinding.instance.addObserver(this);
    appOpenAdManager.loadAd();
    EasyLoading.dismiss();
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.musicplayerbanner();
  }

  @override
  void dispose() {
    // _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _pageManager.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused && issharebutton) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
      issharebutton = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.secondarycolor,
        body: Column(
          children: [
            Container(
              color: colors.secondarycolor,
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.02,
            ),
            //appbar
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: SizedBox(
                width: Constants.screenWidth(context) * 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                          height: 25,
                          width: 26,
                          child: Image.asset(
                            "assets/images/arrow1.png",
                            fit: BoxFit.contain,
                          )),
                    ),
                    Container(
                      height: 38,
                      width: Constants.screenWidth(context) * 0.37,
                      padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: colors.songappbarcolor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(70),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(70)),
                      ),
                      child: Center(
                        child: Text(
                          "musicplayerappbar".tr,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: colors.secondarycolor,
                              fontSize: 16,
                              fontFamily: "Roboto"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        issharebutton = true;
                        await EasyLoading.show();
                        final uri = Uri.parse(widget.audiourl);
                        final response = await http.get(uri);
                        final bytes = response.bodyBytes;
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/${widget.name}.mp3';
                        File(path).writeAsBytesSync(bytes);
                        EasyLoading.dismiss();
                        await Share.shareFiles([path], text: widget.name);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.share,
                            color: colors.songappbarcolor,
                            size: 26,
                          ),
                          Text(
                            "sh".tr,
                            style: TextStyle(
                                color: colors.songappbarcolor,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            //pic
            SizedBox(
              height: Constants.screenHeight(context) * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.all(15),
                height: Constants.screenHeight(context) * 0.34,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.thumbnail),
                        fit: BoxFit.cover),
                    color: colors.songappbarcolor,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Text(
              widget.name,
              style: TextStyle(
                  color: colors.songappbarcolor,
                  fontSize: 16,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: Constants.screenHeight(context) * 0.025,
            ),
            Expanded(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              color: colors.songappbarcolor,
              child: Column(
                children: [
                  ValueListenableBuilder<ButtonState>(
                    valueListenable: _pageManager.buttonNotifier,
                    builder: (_, value, __) {
                      switch (value) {
                        case ButtonState.loading:
                          return Lottie.asset(
                            'assets/images/lf20_1ohbsxif.json',
                            repeat: true,
                            reverse: false,
                            animate: false,
                          );
                        case ButtonState.paused:
                          return Lottie.asset(
                            'assets/images/lf20_1ohbsxif.json',
                            repeat: true,
                            reverse: false,
                            animate: false,
                          );
                        case ButtonState.playing:
                          return Lottie.asset(
                            'assets/images/lf20_1ohbsxif.json',
                            repeat: true,
                            reverse: false,
                            animate: true,
                          );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 18.0),
                    child: ValueListenableBuilder<ProgressBarState>(
                      valueListenable: _pageManager.progressNotifier,
                      builder: (_, value, __) {
                        return ProgressBar(
                          progressBarColor: const Color(0xffF0D27C),
                          baseBarColor: Colors.white,
                          thumbRadius: 8,
                          thumbColor: const Color(0xffF0D27C),
                          bufferedBarColor: Colors.white,
                          progress: value.current,
                          buffered: value.buffered,
                          total: value.total,
                          onSeek: _pageManager.seek,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Constants.screenHeight(context) * 0.01,
                  ),
                  ValueListenableBuilder<ButtonState>(
                    valueListenable: _pageManager.buttonNotifier,
                    builder: (_, value, __) {
                      switch (value) {
                        case ButtonState.loading:
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            width: 32.0,
                            height: 32.0,
                            child: CircularProgressIndicator(
                              color: colors.secondarycolor,
                            ),
                          );
                        case ButtonState.paused:
                          return CircleAvatar(
                            backgroundColor: colors.secondarycolor,
                            radius: 23,
                            child: InkWell(
                                splashColor: Colors.amber,
                                onTap: () {
                                  _pageManager.play();
                                },
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  size: 30,
                                  color: colors.songappbarcolor,
                                )),
                          );
                        case ButtonState.playing:
                          return CircleAvatar(
                            backgroundColor: colors.secondarycolor,
                            radius: 23,
                            child: InkWell(
                                onTap: () {
                                  _pageManager.pause();
                                },
                                child: Icon(
                                  Icons.pause,
                                  size: 30,
                                  color: colors.songappbarcolor,
                                )),
                          );
                      }
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
        persistentFooterButtons: [
          Consumer<get_ads>(
            builder: (context, data, child) {
              return Container(
                color: data.ismusicplayerbanner
                    ? Colors.white
                    : Colors.yellow[200],
                width: double.infinity,
                height: Constants.screenHeight(context) * 0.06,
                child: data.ismusicplayerbanner == true
                    ? AdWidget(ad: data.musicplayer_banner)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            textAlign: TextAlign.right,
                            "Ad",
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
              );
            },
          ),
          // // Icon(Icons.exit_to_app),
          //  SizedBox(width: 10,),
        ],
      ),
    );
  }
}
