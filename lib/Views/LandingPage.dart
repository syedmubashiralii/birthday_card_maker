import 'dart:async';
import 'package:birthday_app_new/Controller/AdsController.dart';
import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Views/HomePage.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import '../Widgets/dialog_widgets.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool loading = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getads(),
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  getads() async {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    await applicationBloc.landingpagebanner();
    applicationBloc.showInterstitialStartEndAd();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<get_ads>(context);
    return WillPopScope(
        onWillPop: () {
          return openDialog(context);
        },
        child: Scaffold(
          backgroundColor: colors.secondarycolor,
          body: Background(
            child: Column(
              children: [
                //language icon
                InkWell(
                  onTap: () {
                    _openLanguagePickerDialog();
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: Constants.screenHeight(context) * 0.053,
                        width: Constants.screenHeight(context) * 0.053,
                        decoration: BoxDecoration(
                            color: colors.primarycolor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              Constants.screenHeight(context) * 0.007),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                Icons.translate_rounded,
                                color: colors.secondarycolor,
                              )),
                        ),
                      )),
                ),
                SizedBox(
                  height: Constants.screenHeight(context) * 0.03,
                ),
                //image
                SizedBox(
                    height: Constants.screenHeight(context) * 0.3,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(
                        "assets/images/Imae.png",
                        fit: BoxFit.contain,
                      ),
                    )),
                //appname
                SizedBox(
                    height: Constants.screenHeight(context) * 0.15,
                    width: Constants.screenHeight(context) * 1.0,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Image.asset(
                        "assets/images/Bd.png",
                        // fit: BoxFit.contain,
                      ),
                    )),
                SizedBox(
                  height: Constants.screenHeight(context) * 0.01,
                ),
                //description text
                SizedBox(
                  height: Constants.screenHeight(context) * 0.09,
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      textAlign: TextAlign.center,
                      "intro_text".tr,
                      style: Constants.currentlang == "ur" ||
                              Constants.currentlang == "ar"
                          ? const TextStyle(
                              fontFamily: 'Baloo2',
                              color: Color(0Xff5A5A5B),
                            )
                          : const TextStyle(
                              fontFamily: 'Baloo2',
                              color: Color(0Xff5A5A5B),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Constants.screenHeight(context) * 0.02,
                  ),
                ),
                //dot indicator
                SizedBox(
                  height: Constants.screenHeight(context) * 0.016,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: Constants.screenHeight(context) * 0.016,
                          backgroundColor: colors.primarycolor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: Constants.screenHeight(context) * 0.016,
                          backgroundColor: colors.primarycolor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                            height: Constants.screenHeight(context) * 0.03,
                            width: Constants.screenWidth(context) * 0.12,
                            decoration: BoxDecoration(
                                color: colors.primarycolor,
                                borderRadius: BorderRadius.circular(20))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Constants.screenHeight(context) * 0.03,
                  ),
                ),
                //get start button
                InkWell(
                  onTap: () {
                    applicationBloc.showInterstitialStartEndAd();
                    Get.to(HomePage());
                  },
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(
                              color: colors.primarycolor, strokeWidth: 2.0),
                        )
                      : Container(
                          height: Constants.screenHeight(context) * 0.07,
                          width: MediaQuery.of(context).size.width * 0.49,
                          decoration: BoxDecoration(
                            color: colors.primarycolor,
                            borderRadius: BorderRadius.circular(34),
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0),
                              BoxShadow(
                                  color: Colors.pink.shade100,
                                  offset: const Offset(-2.0, -2.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Center(
                              child: Text(
                                  textAlign: TextAlign.center,
                                  "start_button".tr,
                                  style: TextStyle(
                                      fontFamily: 'Baloo2',
                                      color: colors.secondarycolor)),
                            ),
                          ),
                        ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Constants.screenHeight(context) * 0.03,
                  ),
                ),
                //privacy button
                InkWell(
                  onTap: () {
                    showDialogLoading(context);
                  },
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: Constants.screenHeight(context) * 0.053,
                        width: Constants.screenHeight(context) * 0.053,
                        decoration: BoxDecoration(
                            color: colors.primarycolor,
                            borderRadius: BorderRadius.circular(100)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              Constants.screenHeight(context) * 0.007),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                Icons.privacy_tip_outlined,
                                color: colors.secondarycolor,
                              )),
                        ),
                      )),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: applicationBloc.islandingpagebanner
                ? Colors.white
                : Colors.yellow[200],
            width: double.infinity,
            height: Constants.screenHeight(context) * 0.07,
            child: applicationBloc.islandingpagebanner == true
                ? AdWidget(ad: applicationBloc.landingpage_banner)
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
          ),
        ));
  }

  final supportedLanguages = [
    Languages.english,
    Languages.french,
    Languages.urdu,
    Languages.portuguese,
    Languages.hindi,
    Languages.arabic,
    Languages.spanish,
    Languages.dutch
  ];

// It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                languages: supportedLanguages,
                titlePadding: const EdgeInsets.all(8.0),
                title: const Text('Select your language'),
                onValuePicked: (Language language) => setState(() {
                      Constants.currentlang = language.isoCode;
                      Get.updateLocale(Locale(language.isoCode));
                    }),
                itemBuilder: _buildDialogItem)),
      );
}
