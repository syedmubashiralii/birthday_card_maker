// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class BCMNotification {
  static BuildContext context = context;
  setContext(BuildContext cont) {
    context = cont;
  }

  // static listenBCMNotification() {
  //   AwesomeNotifications().actionStream.listen((receivedNotification) {
  //     print(receivedNotification.body);
  //     // await AwesomeNotifications().getGlobalBadgeCounter().then(
  //     //     (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1));
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => MyEmployeeList()));
  //   });
  // }

  static notify(String title, body, channelKey) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String pic = "http://134.209.195.127/json/thumbnail_0521_04.png";
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: channelKey,
        title: title,
        autoDismissible: true,
        color: Colors.deepPurple,
        backgroundColor: Colors.white,
        body: body,
        bigPicture: pic,
        notificationLayout: NotificationLayout.BigPicture,
      ),
      // schedule: NotificationInterval(
      //     interval: 60, timeZone: localTimeZone, repeats: true)
    );
  }
}
