// ignore_for_file: non_constant_identifier_names

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Editor/edit_photo/edit_photo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void showDialogLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
          clipBehavior: Clip.antiAlias,
          backgroundColor: colors.secondarycolor,
          title: Text(
            "Privacy Policy",
            style:
                TextStyle(fontFamily: "RobobtoB", color: colors.primarycolor),
          ),
          content: FractionallySizedBox(
            heightFactor: 0.7,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: colors.secondarycolor,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Text(
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              "Jk Apps Provide Free tools,Games and Entertainment material, Mostly in the form of Apps for mobile devices.Jk apps repects the privacy of the users of all Jk apps especially their personal information like contacts or other saved contents throughout the lifetime of the App usage.According to the policy Name & Photo on Birthday Cake does not collect,store , process or transmit any personal information outside the device on which the App is installed beyond the stated and publicly declared functions of any Apps. Moreover,this photo editor does not share user's personal information with other Apps, devices, profiles or third party even on the device on which App is installed for any reason whatsoever.")),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        launchUrl(
                            Uri.parse("https://www.khastech.com/privacy.html"));
                      },
                      child: Text(
                          style: TextStyle(
                              fontSize: 13, color: colors.primarycolor),
                          "You may visit our web site for more information."))
                ],
              ),
            ),
          ));
    },
  );
}

void getxdialog(Color color, Color tcolor, Color bcolor) {
  Get.defaultDialog(
    title: "Loading!",
    content: Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: CircularProgressIndicator(strokeWidth: 2.0, color: color),
    ),
    backgroundColor: bcolor,
    barrierDismissible: false,
    titleStyle: TextStyle(color: tcolor),
  );
}

void underCostruction(BuildContext context) {
  Get.defaultDialog(
      title: "Loading!",
      content: Padding(
          padding: EdgeInsets.only(bottom: 14.0),
          child: Text(
            "Plugin Under Construction",
            style: TextStyle(color: colors.primarycolor),
          )),
      backgroundColor: colors.secondarycolor,
      barrierDismissible: true,
      titleStyle: TextStyle(color: colors.primarycolor),
      textConfirm: "OK",
      buttonColor: colors.primarycolor,
      confirmTextColor: colors.secondarycolor,
      onConfirm: () {
        Navigator.pop(context);
      });
}

void getxsnackbar(Color bcolor, IconData icon, String title, String message) {
  Get.snackbar(
    title,
    message,
    icon: Icon(icon, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: bcolor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

void showInfoDialog(BuildContext context, String text, [IconData? iconData]) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Icon(iconData, size: 50),
                ),
              ),
            Text(
              text,
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      );
    },
  );
}

Future<T?> SavePicture<T>(
    BuildContext context, VoidCallback albumtap, VoidCallback remindertap) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: colors.secondarycolor,
        title: Text(
          "Save your Creation",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.primarycolor,
              fontFamily: "BalooB"),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You can Save & set Reminder on your card.",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  color: colors.primarycolor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: albumtap,
            child: Text(
              "Save To Album",
              style: TextStyle(color: colors.primarycolor),
            ),
          ),
          ElevatedButton(
            onPressed: remindertap,
            style: ElevatedButton.styleFrom(
              primary: colors.primarycolor,
            ),
            child: Text(
              "Set As Reminder",
              style: TextStyle(color: colors.secondarycolor),
            ),
          )
        ],
      );
    },
  );
}

void showBanner(
  BuildContext context, {
  Color color = Colors.grey,
  String title = "",
  List<Widget> actions = const [SizedBox()],
}) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      elevation: 1,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      backgroundColor: color,
      content: Text(
        title,
      ),
      actions: actions,
    ),
  );
}

Widget nointernet(BuildContext context) {
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Icon(PhosphorIcons.wifiXBold, size: 50),
          ),
        ),
        const Text(
          "No Internet Connection!",
        ),
        const Text(
          "Please Connect to internet!!!",
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: iconButton(onTap: () {}, icon: Icons.done),
          ),
        )
      ],
    ),
  );
}
