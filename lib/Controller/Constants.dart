// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sticker_view/stickerview.dart';

class colors {
  static Color primarycolor = Color(0xffE38B9B);
  static Color secondarycolor = Color(0xffF9F3D7);
  static Color textcolor = Color(0xffE38B9B);
  static Color songappbarcolor = Color(0xff7863A0);
  static Color songslistcolor = Color(0xff8B79AE);
  static Color reminderappbarcolor = Color(0xffF0D27C);
  static Color invitationappbarcolor = Color(0xff8BE3D3);
  static Color categorytextcolor = Color(0xff5A5A5B);
  static Color editingtextcolor = Color(0xffffffff);
}

class utils {
  static cacheimage(BuildContext context, String imageurl) {
    precacheImage(
      AdvancedNetworkImage(
        imageurl,
        useDiskCache: true,
        cacheRule: CacheRule(maxAge: const Duration(days: 7)),
      ),
      context,
    );
  }
}

class Constants {
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static void showToast(String toastMessage) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[300],
        textColor: Colors.white);
  }

  static String screen = "";
  static bool isreminder = false;
  static Uint8List? uint8image;
  static String currentlang = "";
  static String cardpath = "";
  static String jsonpath = "";
  static bool iseditingmode = false;
  static String Songurl = "";
  static String fontfamily = "Baloo2";
  static List<Sticker> stickerlist = [];
  static bool isjson = false;
  static String SubCategoryurl =
      "http://134.209.195.127/api/index.php?all=yes&keys=Birthday_App/invitation_Cards/Anniversary_Party";
  static String generalwcakeurl =
      "http://134.209.195.127/api/index.php?all=yes&keys=Birthday_App/Cards_W_Cake";
  static String cakesCategory = "";
  static String cardsCategory = "";
  static String generalwocakeurl =
      "http://134.209.195.127/api/index.php?all=yes&keys=Birthday_App/Cards_WO_Cake";
  static List<Color> textcolor = [
    Color(0xffE38B9B),
    Color(0xffF9F3D7),
    Color(0xff8BE3D3),
    Color(0xffF0D27C),
    Color(0xff8B79AE),
    Color(0xff8B79AE)
  ];
  static List<String> fontlist = [
    "Baloo2",
    "Roboto",
    "RobotoR",
    "BalooM",
    "BalooB"
  ];
  static List<String> imageLinks = [
    "http://134.209.195.127///img//y27.png",
    "http://134.209.195.127/json/y28.png",
    "http://134.209.195.127//json/y27.png",
    "http://134.209.195.127//json/y26.png",
    "http://134.209.195.127//json/y25.png",
    "http://134.209.195.127/json/y24.png",
    "http://134.209.195.127//json/y23.png",
    "http://134.209.195.127/json/y21.png",
    "http://134.209.195.127/json/y20.png",
    "http://134.209.195.127/json/y19.png",
    "http://134.209.195.127/json/y18.png",
    "http://134.209.195.127/json/y17.png",
    "http://134.209.195.127/json/y16.png",
    "http://134.209.195.127/json/y15.png",
    "http://134.209.195.127/json/y14.png",
    "http://134.209.195.127/json/y13.png",
    "http://134.209.195.127/json/y12.png",
    "http://134.209.195.127/json/y11.png",
    "http://134.209.195.127/json/y10.png",
    "http://134.209.195.127///img//y9.png",
    "http://134.209.195.127///img//y8.png",
    "http://134.209.195.127///img//y7.png",
    "http://134.209.195.127///img//y6.png",
    "http://134.209.195.127///img//y5.png",
    "http://134.209.195.127/json/t32.png",
    "http://134.209.195.127//json/sc26.png",
    "http://134.209.195.127///img//sc25.png",
    "http://134.209.195.127///img//sc24.png",
    "http://134.209.195.127///img//sc23.png",
    "http://134.209.195.127///img//sc22.png",
    "http://134.209.195.127/json/sc21.png",
    "http://134.209.195.127///img//sc20.png",
    "http://134.209.195.127///img//sc19.png",
    "http://134.209.195.127///img//sc18.png",
    "http://134.209.195.127/json/Layer125.png",
    "http://134.209.195.127///img//Layer124.png",
    "http://134.209.195.127/json/Layer123.png",
    "http://134.209.195.127///img//Layer122.png",
    "http://134.209.195.127/json/Layer77.png",
    "http://134.209.195.127///img//Layer76.png",
    "http://134.209.195.127/json/Layer75.png",
    "http://134.209.195.127///img//Layer74.png",
    "http://134.209.195.127/json/confetti.png",
    "http://134.209.195.127/json/Emojione_1F389.png",
  ];

  static showDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "No Internet Connection!",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text("Please Connect to Internet"),
          actions: [
            CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
