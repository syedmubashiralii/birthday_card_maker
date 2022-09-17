import 'dart:io';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Models/ReminderModel.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/AddReminder.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../BLoC/application_bloc.dart';
import '../../Controller/AdsController.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  List<dynamic> data = [];
  @override
  initState() {
    _getreminder();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getads(),
    );
    EasyLoading.dismiss();
    super.initState();
  }

  _getreminder() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 100), () {});
    data = await applicationBloc.getreminders();
  }

  getads() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.createBackInterstitialad();
    applicationBloc.Reminderlistbanner();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final ads = Provider.of<get_ads>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            ads.showbackinterstitial();
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
        backgroundColor: colors.reminderappbarcolor,
        elevation: 0,
        title: Text(
          "reminderappbar".tr,
          style: const TextStyle(
              fontFamily: "Roboto", fontSize: 22, color: Color(0xff5A5A5B)),
        ),
        centerTitle: true,
      ),
      body: Background(
          child: applicationBloc.loading
              ? SizedBox(
                  height: Constants.screenHeight(context) * 0.59,
                  child: Center(
                      child: CupertinoActivityIndicator(
                    color: colors.songslistcolor,
                    radius: 20,
                  )))
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      itemCount: data.length > 0 ? data.length : 1,
                      itemBuilder: (context, index) {
                        if (data.isEmpty) {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 100),
                              height: 399,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.doc_text_search,
                                    color: colors.reminderappbarcolor,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "nreminder".tr,
                                    style: const TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 20,
                                        color: Color(0xff5A5A5B)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 12, bottom: 12),
                              height: 85,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: colors.reminderappbarcolor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      data[index]['pic'] == ""
                                          ? Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ))
                                          : Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          data[index]['pic'])),
                                                      fit: BoxFit.cover)),
                                            ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index]['r_title'],
                                                style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontFamily: "Roboto",
                                                    color: Color(0xff5A5A5B),
                                                    fontSize: 15),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    data[index]['rdate'],
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: "Roboto",
                                                        color:
                                                            Color(0xff5A5A5B),
                                                        fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons.watch_later_outlined,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    data[index]['rtime'],
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontFamily: "Roboto",
                                                        color:
                                                            Color(0xff5A5A5B),
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await applicationBloc.deletereminder(
                                              data[index]['reminder_id']);
                                          _getreminder();
                                        },
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.delete,
                                            size: 28,
                                            color: Color(0xff5A5A5B),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          );
                        }
                      }),
                )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 5.0),
        child: Container(
            height: 75.0,
            width: 75.0,
            decoration: BoxDecoration(
                color: colors.reminderappbarcolor,
                border: Border.all(
                  width: 1.5,
                  color: const Color(0xff5A5A5B),
                ),
                borderRadius: BorderRadius.circular(100)),
            child: FloatingActionButton(
                backgroundColor: colors.reminderappbarcolor,
                onPressed: () {
                  Constants.cardpath = "";
                  Get.off(const AddReminder());
                },
                child: const Icon(
                  Icons.add,
                  color: Color(0xff5A5A5B),
                  size: 50,
                ))),
      ),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color: data.isreminderlistbanner ? Colors.white : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.isreminderlistbanner == true
                  ? AdWidget(ad: data.reminderlist_banner)
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
