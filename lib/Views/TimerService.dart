import 'dart:async';
import '../Database/DBHelper.dart';
import 'localnotifications.dart';

Future<void> TimerService() async {
  Timer.periodic(const Duration(minutes: 1), (timer) async {
    var now = DateTime.now();
    List<dynamic> reminders = await DBHelper().getreminder();
    for (var item in reminders) {
      var now = DateTime.now();
      var day = now.day < 10 ? "0${now.day}" : now.day.toString();
      var month = now.month < 10 ? "0${now.month}" : now.month.toString();
      var date = "${now.year}-$month-$day";
      //  var date = "${now.day}/${now.month}/${now.year}";
      var minute = now.minute < 10 ? "0${now.minute}" : now.minute.toString();
      var time = "${now.hour}:$minute";
      //var time = "${now.hour}:${now.minute}";
      if (item['rdate'] == date && item["rtime"] == time) {
        BCMNotification.notify(
            "Birthday Reminder", item['r_title'].toString(), "basic_channel");
      }
    }
  });
}
