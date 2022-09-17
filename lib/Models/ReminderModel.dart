import 'dart:convert';

class Reminder {
  String title = "";
  String date = "";
  String time = "";
  String isrepeated = "";
  String status = "";
  String repetitiontime = "0";
  String pic = "";

  Reminder(this.title, this.date, this.time, this.isrepeated, this.status,
      this.repetitiontime, this.pic);
  Reminder.fromMap(Map map) {
    title = map[title];
    date = map[date];
    time = map[time];
    isrepeated = map[isrepeated];
    status = map[status];
    repetitiontime = map[repetitiontime];
    pic = map[pic];
  }
}

ReminederModel reminederModelFromMap(String str) =>
    ReminederModel.fromMap(json.decode(str));

String reminederModelToMap(ReminederModel data) => json.encode(data.toMap());

class ReminederModel {
  ReminederModel({
    this.reminderId,
    required this.rTitle,
    required this.rdate,
    required this.rtime,
    required this.isrepeated,
    required this.status,
    required this.repetitionTime,
    required this.pic,
  });

  String? reminderId;
  String rTitle;
  String rdate;
  String rtime;
  String isrepeated;
  String status;
  String repetitionTime;
  String pic;

  factory ReminederModel.fromMap(Map<String, dynamic> json) => ReminederModel(
        reminderId: json["reminder_id"],
        rTitle: json["r_title"],
        rdate: json["rdate"],
        rtime: json["rtime"],
        isrepeated: json["isrepeated"],
        status: json["status"],
        repetitionTime: json["repetition_time"],
        pic: json["pic"],
      );

  Map<String, dynamic> toMap() => {
        "reminder_id": reminderId,
        "r_title": rTitle,
        "rdate": rdate,
        "rtime": rtime,
        "isrepeated": isrepeated,
        "status": status,
        "repetition_time": repetitionTime,
        "pic": pic,
      };
}
