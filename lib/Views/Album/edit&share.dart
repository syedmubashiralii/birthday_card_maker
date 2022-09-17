// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:birthday_app_new/Ads/openads.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/EditorScreen.dart';
import 'package:birthday_app_new/Views/Album/Album.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/AddReminder.dart';
import 'package:birthday_app_new/Views/HomePage.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

class EditandShare extends StatefulWidget {
  File imagefile;
  EditandShare({Key? key, required this.imagefile}) : super(key: key);

  @override
  State<EditandShare> createState() => _EditandShareState();
}

class _EditandShareState extends State<EditandShare> with WidgetsBindingObserver {
  FToast? fToast;
  bool issharebutton = false;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;
  // var args = Get.arguments;
  @override
  void initState() {
    EasyLoading.dismiss();
    fToast = FToast();
    fToast!.init(context);
    WidgetsBinding.instance.addObserver(this);
    appOpenAdManager.loadAd();
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;}
    if (state == AppLifecycleState.resumed && isPaused && issharebutton) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
      issharebutton = false;}}
        @override
  void dispose() {
    // _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.secondarycolor,
      appBar: AppBar(
        backgroundColor: colors.primarycolor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.clear)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Image.file(File(widget.imagefile.path)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          Constants.cardpath = widget.imagefile.path;
                          Get.to(() => const AddReminder());
                        },
                        icon: Icon(PhosphorIcons.alarmBold,
                            size: 40, color: colors.primarycolor)),
                    Text(
                      'reminderr'.tr,
                      style:
                          TextStyle(fontSize: 20, color: colors.primarycolor),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                           issharebutton = true;
                          var path = widget.imagefile.path;
                          Share.shareFiles([path],
                              text:
                                  'Courtesy of Birthday Card Maker\nhttp://bit.ly/2O1cGoS');
                        },
                        icon: Icon(Icons.share,
                            size: 40, color: colors.primarycolor)),
                    Text(
                      'sh'.tr,
                      style:
                          TextStyle(fontSize: 20, color: colors.primarycolor),
                    )
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Column(
                  children: [
                    IconButton(
                        onPressed: () async {
                          await widget.imagefile.delete();
                          _showToast("Picture deleted Successfully!!");
                          await Future.delayed(
                              const Duration(milliseconds: 1000), () {});
                          Get.off(() => const ShowAlbum());
                        },
                        icon: Icon(Icons.delete,
                            size: 40, color: colors.primarycolor)),
                    Text(
                      'delete'.tr,
                      style:
                          TextStyle(fontSize: 20, color: colors.primarycolor),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showToast(String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIcons.maskHappyLight),
          SizedBox(
            width: 12.0,
          ),
          Text(text),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: Duration(seconds: 2),
    );
  }
}
