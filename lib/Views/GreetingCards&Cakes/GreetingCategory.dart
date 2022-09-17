// ignore_for_file: use_build_context_synchronously

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Models/GreetingCategoryModel.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../BLoC/application_bloc.dart';
import '../../Controller/AdsController.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../Widgets/dialog_widgets.dart';
import 'CardswithCake.dart';

class GreetingCategory extends StatefulWidget {
  const GreetingCategory({Key? key}) : super(key: key);

  @override
  State<GreetingCategory> createState() => _GreetingCategoryState();
}

class _GreetingCategoryState extends State<GreetingCategory> {
  bool loading = true;
  List<dynamic> data = [];
  List<PersonalCategoryModel> cards = [];
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _getgreetingcategory(),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getads(),
    );
    EasyLoading.dismiss();
    super.initState();
  }

  getads() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createBackInterstitialad();
    applicationBloc.greetingCategoryBanner();
  }

  _getgreetingcategory() async {
    getxdialog(colors.primarycolor, colors.primarycolor, colors.secondarycolor);
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    data = await applicationBloc.getgreetingcategory();
    cards = [];
    for (var items in data) {
      // cards.add(InvitationCategoryModel.fromJson(items));
      cards.add(PersonalCategoryModel(
          categoryThumbnail: items["category_thumbnail"],
          subcategoryCards: items["Subcategory_Cards"],
          subcategoryCakes: items["Subcategory_Cakes"],
          name: items["name"]));
    }
    setState(() {
      loading = false;
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.back(); // Prints after 1 second.
    });
  }

  final customCacheManager = CacheManager(Config("customCacheKey",
      stalePeriod: const Duration(days: 10), maxNrOfCacheObjects: 1000));
  @override
  Widget build(BuildContext context) {
    final ad = Provider.of<get_ads>(context);
    return Scaffold(
      backgroundColor: Color(0xffF9F3D7),
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            ad.showbackinterstitial();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pop(context);
            });
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
          "scategory".tr,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 22, color: colors.secondarycolor),
        ),
        centerTitle: true,
      ),
      body: Background(
        child: loading
            ? Container()
            : GridView.builder(
                // shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 3.5,
                  mainAxisSpacing: 20.5,
                  crossAxisCount: 3,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      bool result =
                          await InternetConnectionChecker().hasConnection;
                      if (result == true) {
                        Constants.cakesCategory = cards[index]
                            .subcategoryCakes!
                            .split(',')[0]
                            //.split("/Cards_W_Cake")[0]
                            .toString();
                        Constants.cardsCategory = cards[index]
                            .subcategoryCards!
                            .split(',')[0]
                            //.split("/Cards_WO_Cake")[0]
                            .toString();

                        Get.to(() => const CardswithCake());
                      } else {
                        // EasyLoading.dismiss();
                        await Constants.showDialog(context);
                      }
                    },
                    child: imgwidget(
                      context,
                      index,
                      cards[index].categoryThumbnail.toString(),
                    ),
                  );
                }),
      ),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color:
                  data.iscategorypagebanner ? Colors.white : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.iscategorypagebanner == true
                  ? AdWidget(ad: data.category_pagebanner)
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

  Widget imgwidget(BuildContext context, int index, String url) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Constants.screenWidth(context) * 0.3,
          height: Constants.screenHeight(context) * 0.11,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: CachedNetworkImage(
            cacheManager: customCacheManager,
            key: UniqueKey(),
            imageUrl: url,
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(
                  color: colors.primarycolor,
                ),
              );
            },
            errorWidget: (context, url, error) => Container(
              child: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            //maxHeightDiskCache: 75,
          ),
        ),
        Flexible(
          child: Text(
            Constants.currentlang == "ur"
                ? cards[index].name.toString().split(",")[5]
                : Constants.currentlang == "pt"
                    ? cards[index].name.toString().split(",")[4]
                    : Constants.currentlang == "fr"
                        ? cards[index].name.toString().split(",")[7]
                        : Constants.currentlang == "nl"
                            ? cards[index].name.toString().split(",")[6]
                            : Constants.currentlang == "hi"
                                ? cards[index].name.toString().split(",")[1]
                                : Constants.currentlang == "ar"
                                    ? cards[index].name.toString().split(",")[2]
                                    : Constants.currentlang == "es"
                                        ? cards[index]
                                            .name
                                            .toString()
                                            .split(",")[3]
                                        : cards[index]
                                            .name
                                            .toString()
                                            .split(",")[0],
            style: GoogleFonts.poppins(
                textStyle: Constants.currentlang == "ur" ||
                        Constants.currentlang == "ar"
                    ? TextStyle(
                        color: colors.categorytextcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis)
                    : TextStyle(
                        color: colors.categorytextcolor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis)),
          ),
        )
      ],
    );
  }
}
