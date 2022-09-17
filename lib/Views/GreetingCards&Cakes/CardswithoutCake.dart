// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../BLoC/application_bloc.dart';
import '../../Controller/AdsController.dart';
import '../../Editor/JsonEditor.dart';
import '../../Models/InvitationSubCategoryModel.dart';
import '../../Editor/EditorScreen.dart';
import '../../Widgets/dialog_widgets.dart';
import 'CardswithCake.dart';
import 'Components.dart';

class CardswithoutCake extends StatefulWidget {
  const CardswithoutCake({Key? key}) : super(key: key);

  @override
  State<CardswithoutCake> createState() => _CardswithCakeState();
}

class _CardswithCakeState extends State<CardswithoutCake> {
  bool isloading = true;
  List<dynamic> data = [];
  List<InvitationSubCategoryModel> wocake = [];
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getcardswocakes(),
    );
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.CreateCardInterstitial();
    applicationBloc.cardswithoutcakebanner();
    super.initState();
  }

  _getcardswocakes() async {
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    data = await applicationBloc.getgreetingsubcatregorywocake();
    wocake = [];
    for (var items in data) {
      wocake.add(InvitationSubCategoryModel(
          thumbnailLink: items['thumbnail_link'],
          templateJsonLink: items['template_json_link']));
    }
    await cache();
  }

  cache() async {
    wocake
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

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<get_ads>(context);
    return Scaffold(
      backgroundColor: Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
              fontFamily: "Roboto", fontSize: 22, color: colors.secondarycolor),
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
              outlinedchip(
                tcolor: colors.primarycolor,
                bcolor: colors.primarycolor,
                text: "cardwcake".tr,
                color: colors.secondarycolor,
                ontap: () async {
                  bool result = await InternetConnectionChecker().hasConnection;
                  if (result == true) {
                    Get.off(() => const CardswithCake());
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
                tcolor: colors.secondarycolor,
                img: "assets/images/button2.png",
                text: "cardwocake".tr,
                ontap: () {},
              ),
            ],
          ),
          SizedBox(height: Constants.screenHeight(context) * .02),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
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
                          itemCount: wocake.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () async {
                                  await EasyLoading.show();
                                  var path =
                                      "http://134.209.195.127/${wocake[index].templateJsonLink}";
                                  print(Constants.isjson);
                                  Constants.isjson = path.contains(".json");
                                  print(Constants.isjson);
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    applicationBloc.showcardinterstitialad();
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      Get.to(() => JsonEditor(
                                            img:
                                                "http://134.209.195.127/${wocake[index].templateJsonLink}",
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
                                      "http://134.209.195.127/${wocake[index].thumbnailLink}",
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
              color:
                  data.iscardwocakebanner ? Colors.white : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.iscardwocakebanner == true
                  ? AdWidget(ad: data.cardswocake_banner)
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
