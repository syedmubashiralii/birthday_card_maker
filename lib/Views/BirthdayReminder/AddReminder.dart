import 'dart:io';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:birthday_app_new/Views/Album/Album.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/Components.dart';
import 'package:birthday_app_new/Views/BirthdayReminder/ReminderList.dart';
import 'package:birthday_app_new/Widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../BLoC/application_bloc.dart';
import '../../Controller/AdsController.dart';
import '../../Widgets/dialog_widgets.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  @override
  void initState() {
    EasyLoading.dismiss();
    Constants.isreminder = false;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => getads(),
    );
    super.initState();
  }

  getads() {
    final applicationBloc = Provider.of<get_ads>(context, listen: false);
    applicationBloc.addreminderbanner();
  }

  @override
  bool muted = false;
  DateTime date = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        var test = selectedTime.toString().split("(")[1];
        timetext = test.toString().split(")")[0];
      });
    }
  }

  var pickedDate;
  Duration initialtimer = new Duration();
  String datetext = "date".tr;
  String timetext = "time".tr;
  String datee = "Date";
  String time = "Time";
  String repeattext = "repeat".tr;
  var title = TextEditingController();
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
          "sreminder".tr,
          style: const TextStyle(
              fontFamily: "Roboto", fontSize: 20, color: Color(0xff5A5A5B)),
        ),
        centerTitle: true,
      ),
      body: Background(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(15),
                  height: Constants.screenHeight(context) * 0.68,
                  width: Constants.screenWidth(context) * 0.85,
                  decoration: BoxDecoration(
                      color: colors.reminderappbarcolor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 45,
                      ),
                      InkWell(
                        onTap: () {
                          if (Constants.cardpath == "") {
                            Constants.isreminder = true;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShowAlbum()));
                          }
                          return;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Constants.cardpath != ""
                                  ? Container(
                                      alignment: Alignment.center,
                                      height:
                                          Constants.screenWidth(context) * 0.30,
                                      width:
                                          Constants.screenWidth(context) * 0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: FileImage(
                                                  File(Constants.cardpath)),
                                              fit: BoxFit.cover)),
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height:
                                              Constants.screenWidth(context) *
                                                  0.15,
                                          width:
                                              Constants.screenWidth(context) *
                                                  0.15,
                                          decoration: BoxDecoration(
                                              color: colors.secondarycolor,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff5A5A5B),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: const Icon(
                                            Icons.add,
                                            color: Color(0xff5A5A5B),
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "scard".tr,
                                          style: const TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 13,
                                              color: Color(0xff5A5A5B)),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
//title
                      SizedBox(
                          height: 50,
                          child: MyInputField(
                              controller: title, hint: "title".tr)),
                      const SizedBox(
                        height: 20,
                      ),
                      //date

                      SizedBox(
                          height: 40,
                          child: Picker(
                            ontap: () async {
                              pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2025));
                              if (pickedDate != null) {
                                date = DateTime.parse(pickedDate.toString());
                                setState(() {});
                                datetext = pickedDate.toString().split(' ')[0];
                              }
                              // showCupertinoModalPopup<void>(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return _buildBottomPicker(datetimePicker());
                              //     });
                            },
                            text: datetext,
                            icon: Icons.date_range_rounded,
                          )),
                      const SizedBox(
                        height: 20,
                      ),

                      //time

                      SizedBox(
                          height: 40,
                          child: Picker(
                            ontap: () {
                              _selectTime(context);
                              // showCupertinoModalPopup<void>(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return _buildBottomPicker(timePicker());
                              //     });
                            },
                            text: timetext,
                            icon: Icons.watch_later_outlined,
                          )),

                      const SizedBox(
                        height: 20,
                      ),

                      //repeat

                      SizedBox(
                          height: 40,
                          child: Picker(
                            ontap: () {},
                            text: repeattext,
                            icon: Icons.repeat_rounded,
                          )),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Button(
                          ontap: () async {
                            if (title.text.isEmpty ||
                                datetext == "Date" ||
                                timetext == "Time") {
                              getxsnackbar(Colors.red, Icons.error, "Failure",
                                  "cinfo".tr);
                              // EasyLoading.showToast("cinfo".tr,
                              //     toastPosition:
                              //         EasyLoadingToastPosition.bottom);
                            } else {
                              await applicationBloc.addreminder(
                                  title.text,
                                  datetext,
                                  timetext,
                                  Constants.cardpath,
                                  muted.toString());
                              getxsnackbar(Colors.green, Icons.done, "Success",
                                  "stored".tr);
                              // EasyLoading.showToast("stored".tr,
                              //     toastPosition:
                              //         EasyLoadingToastPosition.bottom);
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              Constants.cardpath = "";
                              Get.off(const ReminderList());
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: Constants.screenWidth(context) * 0.15,
                  width: Constants.screenWidth(context) * 0.15,
                  decoration: BoxDecoration(
                      color: colors.secondarycolor,
                      border:
                          Border.all(color: const Color(0xff5A5A5B), width: 2),
                      borderRadius: BorderRadius.circular(100)),
                  child: InkWell(
                    onTap: () {
                      if (muted == false) {
                        muted = true;
                        setState(() {});
                      } else {
                        muted = false;
                        setState(() {});
                      }
                    },
                    child: Icon(
                      muted
                          ? Icons.notifications_off_outlined
                          : Icons.notifications_none,
                      color: const Color(0xff5A5A5B),
                      size: 28,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      )),
      persistentFooterButtons: [
        Consumer<get_ads>(
          builder: (context, data, child) {
            return Container(
              color:
                  data.isaddreminderbanner ? Colors.white : Colors.yellow[200],
              width: double.infinity,
              height: Constants.screenHeight(context) * 0.06,
              child: data.isaddreminderbanner == true
                  ? AdWidget(ad: data.addreminder_banner)
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

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget timePicker() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hms,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          timetext = changedtimer.inHours.toString() +
              ':' +
              (changedtimer.inMinutes % 60).toString();
        });
      },
    );
  }

  Widget datetimePicker() {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        setState(() {
          datetext = (newdate.day.toString() +
              '/' +
              newdate.month.toString() +
              '/' +
              newdate.year.toString());
        });
      },
      use24hFormat: true,
      maximumDate: new DateTime(2025, 12, 30),
      minimumYear: 2021,
      maximumYear: 2025,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.date,
    );
  }
}
