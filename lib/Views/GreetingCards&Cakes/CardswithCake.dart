// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names, non_constant_identifier_names

import 'dart:developer';
import 'dart:typed_data';
import 'package:birthday_app_new/Editor/JsonEditor.dart';
import 'package:flutter/material.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Views/GreetingCards&Cakes/CardswithoutCake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../../BLoC/application_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../Controller/AdsController.dart';
import '../../Models/InvitationSubCategoryModel.dart';
import '../../Editor/EditorScreen.dart';
import '../../Widgets/dialog_widgets.dart';
import 'Components.dart';

class CardswithCake extends StatefulWidget {
  const CardswithCake({Key? key}) : super(key: key);

  @override
  State<CardswithCake> createState() => _CardswithCakeState();
}

class _CardswithCakeState extends State<CardswithCake> {
  bool isloading = true;
  List<dynamic> data = [];
  List<InvitationSubCategoryModel> subcards = [];
  @override
  initState() {
    isloading = true;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getcardwcakes(),
    );
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.CreateCardInterstitial();
    applicationBloc.cardswithcakebanner();
    super.initState();
  }

  _getcardwcakes() async {
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    //showDialogLoading(context);
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    data = await applicationBloc.getgreetingsubcatregory();
    subcards = [];
    for (var items in data) {
      subcards.add(InvitationSubCategoryModel(
          thumbnailLink: items['thumbnail_link'],
          templateJsonLink: items['template_json_link']));
    }
    // log(data.toString());
    //await Add();
    await cache();
  }

  // List images = [];
  // Add() async {
  //   for (int i = 0; i < subcards.length; i++) {
  //     images.add(Image.network(
  //       "http://134.209.195.127/${subcards[i].thumbnailLink}",
  //       fit: BoxFit.cover,
  //       errorBuilder: (context, error, stackTrace) {
  //         return const Icon(Icons.error);
  //       },
  //     ));
  //   }
  //   await precachedimages();
  // }

  cache() async {
    subcards
        .map((InvitationSubCategoryModel) => utils.cacheimage(context,
            "http://134.209.195.127/${InvitationSubCategoryModel.thumbnailLink}"))
        .toList();
    Future.delayed(const Duration(seconds: 3), () {
      print('One second has passed.');

      Get.back(); // Prints after 1 second.
    });
    setState(() {
      isloading = false;
    });
  }
  // precachedimages() async {
  //   for (int i = 0; i < images.length; i++) {
  //     await precacheImage(images[i].image, context);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  final customCacheManager = CacheManager(Config("customCacheKey",
      stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 1000));
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<get_ads>(context);
    return Scaffold(
        backgroundColor: const Color(0xffF9F3D7),
        appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 15, right: 8),
                child: Image.asset(
                  "assets/images/arrow.png",
                  fit: BoxFit.contain,
                )),
          ),
          backgroundColor: colors.primarycolor,
          title: Text(
            "scard".tr,
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 22,
                color: colors.secondarycolor),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(height: Constants.screenHeight(context) * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                filledchip(
                  tcolor: colors.secondarycolor,
                  img: "assets/images/button2.png",
                  text: "cardwcake".tr,
                  ontap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                outlinedchip(
                  tcolor: colors.primarycolor,
                  bcolor: colors.primarycolor,
                  text: "cardwocake".tr,
                  color: colors.secondarycolor,
                  ontap: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      Get.off(() => const CardswithoutCake());
                    } else {
                      EasyLoading.dismiss();
                      await Constants.showDialog(context);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: Constants.screenHeight(context) * .02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                    height: Constants.screenHeight(context) * .7,
                    width: double.infinity,
                    child: isloading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: colors.primarycolor,
                              strokeWidth: 2,
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 15.5,
                              mainAxisSpacing: 15.5,
                              crossAxisCount: 3,
                            ),
                            itemCount: subcards.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () async {
                                    Constants.stickerlist.clear();
                                    await EasyLoading.show();
                                    var path =
                                        "http://134.209.195.127/${subcards[index].templateJsonLink}";
                                    Constants.jsonpath = path;
                                    print(Constants.isjson);
                                    Constants.isjson = path.contains(".json");
                                    print(Constants.isjson);
                                    bool result =
                                        await InternetConnectionChecker()
                                            .hasConnection;
                                    if (result == true) {
                                      applicationBloc.showcardinterstitialad();
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        Get.to(() => JsonEditor(
                                              img:
                                                  "http://134.209.195.127/${subcards[index].templateJsonLink}",
                                            ));
                                      });
                                    } else {
                                      EasyLoading.dismiss();
                                      Constants.showDialog(context);
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: // Reload feature included
                                        TransitionToImage(
                                      image: AdvancedNetworkImage(
                                        "http://134.209.195.127/${subcards[index].thumbnailLink}",
                                        useDiskCache: true,
                                      ),
                                      loadingWidgetBuilder:
                                          (_, double progress, __) => Center(
                                              child: CircularProgressIndicator(
                                        color: colors.primarycolor,
                                      )),
                                      fit: BoxFit.cover,
                                      placeholder: const Icon(Icons.refresh),
                                      enableRefresh: true,
                                    ),

                                    // images[index]
                                  ));
                            })),
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color: data.iscardwcakebanner
                  ? Colors.white
                  : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.iscardwcakebanner == true
                  ? AdWidget(ad: data.cardswcake_banner)
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
        );
  }
}
