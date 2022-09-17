// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:birthday_app_new/Controller/AdsController.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/ReminderList.dart';
import 'package:birthday_app_new/Views/InvitationCards/BirthdayInvitation.dart';
import 'package:birthday_app_new/Widgets/dialog_widgets.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'Album/Album.dart';
import 'BirthdaySongs/Songslist.dart';
import 'GreetingCards&Cakes/GreetingCategory.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getads(),
    );
    super.initState();
  }

  getads() async {
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createInterstitialStartEndAd();
    applicationBloc.HomePagebanner();
    applicationBloc.createalbumint();
    Future.delayed(const Duration(seconds: 4), () {
      Get.back(); // Prints after 1 second.
    });
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<get_ads>(context);
    return Scaffold(
      drawer: MainDrawer(),
      key: _scaffoldKey,
      body: Container(
        color: colors.secondarycolor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Constants.screenHeight(context) * 0.01,
                  right: Constants.screenWidth(context) * 0.03,
                  left: Constants.screenWidth(context) * 0.03),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: SizedBox(
                        height: Constants.screenHeight(context) * 0.06,
                        width: Constants.screenWidth(context) * 0.08,
                        child:
                            Image.asset("assets/images/Icon feather-menu.png")),
                  ),
                  SizedBox(
                    width: Constants.screenWidth(context) * 0.06,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "home_appbar".tr,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: colors.textcolor,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Constants.screenWidth(context) * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      applicationBloc.showalbumint();
                      Get.to(() => const ShowAlbum());
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: Constants.screenHeight(context) * 0.004,
                        ),
                        Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: colors.textcolor,
                          size: Constants.screenHeight(context) * 0.032,
                        ),
                        Text(
                          "album".tr,
                          style: TextStyle(
                              color: colors.textcolor,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constants.screenHeight(context) * 0.02,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.22,
              // padding: const EdgeInsets.all(8),
              child: Image.asset(
                "assets/images/1.png",
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: Constants.screenHeight(context) * 0.02,
              ),
            ),
            InkWell(
              onTap: () async {
                await EasyLoading.show();
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  applicationBloc.showInterstitialStartEndAd();
                  Future.delayed(const Duration(milliseconds: 1000), () {});
                  Get.to(() => const GreetingCategory());
                } else {
                  await EasyLoading.dismiss();
                  await Constants.showDialog(context);
                }
              },
              child: Container(
                  width: Constants.screenWidth(context) * 0.8,
                  height: Constants.screenHeight(context) * 0.12,
                  margin: EdgeInsets.only(
                      bottom: Constants.screenHeight(context) * 0.01),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/13.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Constants.currentlang == "ur" ||
                              Constants.currentlang == "ar"
                          ? SizedBox(
                              width: Constants.screenWidth(context) * 0.15,
                            )
                          : SizedBox(
                              width: Constants.screenWidth(context) * 0.25,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.038,
                                )
                              : SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.048,
                                ),
                          Text(
                            "greeting".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    color: colors.secondarycolor)
                                : TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 17,
                                    color: colors.secondarycolor),
                          ),
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? const SizedBox(
                                  height: 0,
                                )
                              : const SizedBox(
                                  height: 3,
                                ),
                          Text(
                            "greetings".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 12,
                                    color: colors.secondarycolor)
                                : TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 14,
                                    color: colors.secondarycolor),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                await EasyLoading.show();
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  applicationBloc.showInterstitialStartEndAd();
                  Future.delayed(const Duration(milliseconds: 1000), () {});
                  Get.to(() => const BirthdayInvitation());
                } else {
                  EasyLoading.dismiss();
                  Constants.showDialog(context);
                }
              },
              child: Container(
                  width: Constants.screenWidth(context) * 0.8,
                  height: Constants.screenHeight(context) * 0.12,
                  margin: EdgeInsets.only(
                      bottom: Constants.screenHeight(context) * 0.01),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/12.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Constants.currentlang == "ur" ||
                              Constants.currentlang == "ar"
                          ? SizedBox(
                              width: Constants.screenWidth(context) * 0.15,
                            )
                          : SizedBox(
                              width: Constants.screenWidth(context) * 0.25,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.038,
                                )
                              : SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.048,
                                ),
                          Text(
                            "invitation".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    color: colors.categorytextcolor)
                                : TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 17,
                                    color: colors.categorytextcolor),
                          ),
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? const SizedBox(
                                  height: 0,
                                )
                              : const SizedBox(
                                  height: 3,
                                ),
                          Text(
                            "invitations".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 12,
                                    color: colors.categorytextcolor)
                                : TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 14,
                                    color: colors.categorytextcolor),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                // await EasyLoading.showSuccess('Great Success!');
                // await EasyLoading.showToast(
                //   'Toast',
                // );
                await EasyLoading.show();
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  applicationBloc.showInterstitialStartEndAd();
                  Future.delayed(const Duration(milliseconds: 2000), () {});
                  Get.to(() => const SongsList());
                } else {
                  EasyLoading.dismiss();
                  Constants.showDialog(context);
                }
              },
              child: Container(
                  width: Constants.screenWidth(context) * 0.8,
                  height: Constants.screenHeight(context) * 0.12,
                  margin: EdgeInsets.only(
                      bottom: Constants.screenHeight(context) * 0.01),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/11.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Constants.currentlang == "ur" ||
                              Constants.currentlang == "ar"
                          ? SizedBox(
                              width: Constants.screenWidth(context) * 0.15,
                            )
                          : SizedBox(
                              width: Constants.screenWidth(context) * 0.25,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.038,
                                )
                              : SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.048,
                                ),
                          Text(
                            "songs".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    color: colors.secondarycolor)
                                : TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 17,
                                    color: colors.secondarycolor),
                          ),
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? const SizedBox(
                                  height: 0,
                                )
                              : const SizedBox(
                                  height: 3,
                                ),
                          Text(
                            "songsd".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 12,
                                    color: colors.secondarycolor)
                                : TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 14,
                                    color: colors.secondarycolor),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            InkWell(
              onTap: () async {
                await EasyLoading.show();
                applicationBloc.showInterstitialStartEndAd();
                Future.delayed(const Duration(milliseconds: 1000), () {});
                Get.to(() => const ReminderList());
              },
              child: Container(
                  width: Constants.screenWidth(context) * 0.8,
                  height: Constants.screenHeight(context) * 0.12,
                  margin: EdgeInsets.only(
                      bottom: Constants.screenHeight(context) * 0.01),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/14.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Constants.currentlang == "ur" ||
                              Constants.currentlang == "ar"
                          ? SizedBox(
                              width: Constants.screenWidth(context) * 0.15,
                            )
                          : SizedBox(
                              width: Constants.screenWidth(context) * 0.25,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.038,
                                )
                              : SizedBox(
                                  height:
                                      Constants.screenWidth(context) * 0.048,
                                ),
                          Text(
                            "reminder".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    color: colors.categorytextcolor)
                                : TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 17,
                                    color: colors.categorytextcolor),
                          ),
                          Constants.currentlang == "ur" ||
                                  Constants.currentlang == "ar"
                              ? const SizedBox(
                                  height: 0,
                                )
                              : const SizedBox(
                                  height: 3,
                                ),
                          Text(
                            "reminderd".tr,
                            style: Constants.currentlang != "en"
                                ? TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 12,
                                    color: colors.categorytextcolor)
                                : TextStyle(
                                    fontFamily: "RobotoR",
                                    fontSize: 14,
                                    color: colors.categorytextcolor),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
            Expanded(
              child: SizedBox(
                height: Constants.screenHeight(context) * 0.06,
              ),
            ),
            // Container(
            //   color:applicationBloc.islandingpagebanner ? Colors.transparent
            //     : Colors.yellow[200],
            //   width: double.infinity,
            //   height: Constants.screenHeight(context) * 0.08,
            //   child: applicationBloc.islandingpagebanner
            //       ? AdWidget(ad: applicationBloc.landingpage_banner)
            //       : Center(child: Text("loading")),
            // ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, dataa, child) {
            return Container(
              color: dataa.ishomepagebanner
                  ? Colors.transparent
                  : Colors.yellow[200],
              height: MediaQuery.of(context).size.height * 0.06,
              child: applicationBloc.ishomepagebanner
                  ? AdWidget(ad: dataa.homepage_Banner)
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
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
