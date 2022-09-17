// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:birthday_app_new/BLoC/application_bloc.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Models/InvitationSubCategoryModel.dart';
import 'package:birthday_app_new/Views/InvitationCards/BirthdayInvitation.dart';
import 'package:birthday_app_new/Editor/EditorScreen.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../../Controller/AdsController.dart';
import '../../Editor/JsonEditor.dart';
import '../../Widgets/dialog_widgets.dart';
import '../GreetingCards&Cakes/Components.dart';

class Anniversaryinvitation extends StatefulWidget {
  const Anniversaryinvitation({Key? key}) : super(key: key);

  @override
  State<Anniversaryinvitation> createState() => _AnniversaryinvitationState();
}

class _AnniversaryinvitationState extends State<Anniversaryinvitation> {
  List<dynamic> data = [];
  List<InvitationSubCategoryModel> subcards = [];
  @override
  initState() {
    Constants.SubCategoryurl =
        "http://134.209.195.127/api/index.php?all=yes&keys=Birthday_App/invitation_Cards/Anniversary_Party";
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getinvitationsubcategory(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => getads());

    super.initState();
  }

  getads() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createBackInterstitialad();
    applicationBloc.CreateCardInterstitial();
    applicationBloc.anniversarypagebanner();
  }

  _getinvitationsubcategory() async {
    getxdialog(colors.categorytextcolor, colors.categorytextcolor,
        colors.secondarycolor);
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    data = await applicationBloc.getinvitationsubcategory();
    subcards = [];
    for (var items in data) {
      subcards.add(InvitationSubCategoryModel.fromMap(items));
    }
    Future.delayed(const Duration(seconds: 3), () {
      print('One second has passed.');
      Get.back();
    });
  }

  final customCacheManager = CacheManager(Config("customCacheKey",
      stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 1000));
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final ad = Provider.of<get_ads>(context);
    return Scaffold(
      backgroundColor: Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ad.showbackinterstitial();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pop(context);
            });
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 15, bottom: 15, right: 8),
              child: Image.asset(
                "assets/images/arrow3.png",
                fit: BoxFit.contain,
              )),
        ),
        backgroundColor: colors.invitationappbarcolor,
        title: Text(
          "scard".tr,
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 22,
              color: colors.categorytextcolor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: Constants.screenHeight(context) * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              outlinedchip(
                tcolor: colors.categorytextcolor,
                bcolor: colors.invitationappbarcolor,
                color: colors.secondarycolor,
                text: "birthday".tr,
                ontap: () async {
                  bool result = await InternetConnectionChecker().hasConnection;
                  if (result == true) {
                    Get.off(() => const BirthdayInvitation());
                  } else {
                    EasyLoading.dismiss();
                    await Constants.showDialog(context);
                  }
                },
              ),
              const SizedBox(
                width: 10,
              ),
              filledchip(
                tcolor: colors.categorytextcolor,
                text: "anniversary".tr,
                img: "assets/images/button1.png",
                ontap: () {},
              ),
            ],
          ),
          SizedBox(height: Constants.screenHeight(context) * 0.02),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  height: Constants.screenHeight(context) * .7,
                  width: double.infinity,
                  child: applicationBloc.loading
                      ? Container(
                          height: Constants.screenHeight(context) * 0.59,
                          child: Center(
                              child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                                color: colors.invitationappbarcolor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: CupertinoActivityIndicator(
                                color: colors.secondarycolor,
                                radius: 20,
                              ),
                            ),
                          )))
                      : GridView.builder(
                          shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
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
                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                if (result == true) {
                                  ad.showcardinterstitialad();
                                  Future.delayed(
                                      const Duration(milliseconds: 1000), () {
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
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  cacheManager: customCacheManager,
                                  //key: UniqueKey(),
                                  imageUrl:
                                      "http://134.209.195.127/${subcards[index].thumbnailLink}",
                                  placeholder: (_, __) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: colors.invitationappbarcolor,
                                    ));
                                  },
                                  errorWidget: (_, __, error) => Container(
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                  //maxHeightDiskCache: 75,
                                ),
                              ),
                            );
                          })),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color: data.isanniversarypagebanner
                  ? Colors.white
                  : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.isanniversarypagebanner == true
                  ? AdWidget(ad: data.anniversary_page_banner)
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
