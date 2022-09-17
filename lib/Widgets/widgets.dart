// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Views/Album/Album.dart';
import '../enums/connectivity_status.dart';
import 'dialog_widgets.dart';

class Background extends StatelessWidget {
  Widget child;
  Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: colors.secondarycolor,
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

////
///
///
// drawer widget

class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius:
            Constants.currentlang == "ur" || Constants.currentlang == "ar"
                ? const BorderRadius.horizontal(
                    left: Radius.circular(80.0),
                  )
                : const BorderRadius.horizontal(
                    right: Radius.circular(80.0),
                  ),
        child: Drawer(
            child: Column(
          children: [
            Container(
                decoration: Constants.currentlang == "ur" ||
                        Constants.currentlang == "ar"
                    ? BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80)),
                        color: colors.primarycolor,
                      )
                    : BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(80),
                            bottomLeft: Radius.circular(80)),
                        color: colors.primarycolor,
                      ),
                width: double.infinity,
                height: Constants.screenHeight(context) * 0.3,
                padding: EdgeInsets.all(Constants.screenHeight(context) * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Constants.screenHeight(context) * 0.09,
                      width: Constants.screenWidth(context) * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/Bd.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Constants.screenWidth(context) * 0.4,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          textAlign: TextAlign.start,
                          "drawert".tr,
                          style: Constants.currentlang == "en"
                              ? TextStyle(
                                  fontFamily: 'BalooB',
                                  color: colors.secondarycolor,
                                )
                              : TextStyle(
                                  fontFamily: 'BalooB',
                                  fontWeight: FontWeight.w500,
                                  color: colors.secondarycolor,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Constants.screenWidth(context) * 0.24,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          textAlign: TextAlign.start,
                          "Version:18.1.5",
                          style: TextStyle(
                            fontFamily: 'Baloo2',
                            color: colors.categorytextcolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: Constants.screenHeight(context) * 0.05,
            ),
            MyListTile(
                text: "myalbum".tr,
                ico: CupertinoIcons.photo_on_rectangle,
                ontap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShowAlbum()));
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "privacy".tr,
                ico: Icons.lock_outline_rounded,
                ontap: () {
                  showDialogLoading(context);
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "share".tr,
                ico: Icons.share_outlined,
                ontap: () async {
                  const url = "http://bit.ly/2O1cGoS";
                  await screenshotController.capture().then((Url) async {
                    SocialShare.shareOptions(
                            "Click the link & try out this amazing Birthday app.\n\n${url} ")
                        .then((data) {});
                  });
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "feedback".tr,
                ico: Icons.feedback_outlined,
                ontap: () {
                  launchUrl(emailLaunchUri);
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "more".tr,
                ico: Icons.apps_rounded,
                ontap: () {
                  launchUrl(Uri.parse(
                      "https://play.google.com/store/apps/dev?id=4854990210404955584"));
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "rate".tr,
                ico: Icons.thumb_up_alt_outlined,
                ontap: () {
                  launchUrl(Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.jk.birthdayphoto.nameoncake"));
                  // StoreRedirect.redirect(
                  //     androidAppId: 'shri.complete.fitness.gymtrainingapp',
                  //     iOSAppId: 'com.example.rating');
                }),
            SizedBox(
              height: Constants.screenHeight(context) * 0.002,
            ),
            MyListTile(
                text: "exit".tr,
                ico: Icons.exit_to_app,
                ontap: () {
                  openDialog(context);
                }),
          ],
        )));
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'jkapps@gmail.com',
    query: 'FeedBack',
  );
}

//
///listTileWidget
class MyListTile extends StatelessWidget {
  String text;
  IconData? ico;
  VoidCallback? ontap;
  MyListTile({this.ico, this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        ico,
        color: colors.primarycolor,
        size: Constants.screenHeight(context) * 0.037,
      ),
      title: SizedBox(
        width: Constants.screenHeight(context) * 0.03,
        height: Constants.screenHeight(context) * 0.03,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(text,
              style: TextStyle(
                  fontSize: Constants.screenWidth(context) * 0.05,
                  color: colors.primarycolor,
                  fontFamily: "RobotoR")),
        ),
      ),
      onTap: ontap,
    );
  }
}

//
class Flag extends StatelessWidget {
  String icon;
  VoidCallback ontap;
  Flag({Key? key, required this.icon, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          icon,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Future<bool> openDialog(BuildContext context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: colors.primarycolor,
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.exit_to_app,
                      size: 30,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  const Text(
                    'Exit app',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Are you sure to exit app?',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.cancel,
                      color: colors.primarycolor,
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    'Cancel',
                    style: TextStyle(
                        color: colors.primarycolor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Icon(
                      Icons.check_circle,
                      color: colors.primarycolor,
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                        color: colors.primarycolor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        );
      })) {
    case 0:
      break;
    case 1:
      exit(0);
  }
  return false;
}



//network Sensitive


