// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/ReminderModel.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Birthday.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table

    await db.execute(
        //"DROP TABLE addresses",
        "CREATE TABLE IF NOT EXISTS reminder(reminder_id INTEGER PRIMARY KEY AUTOINCREMENT,r_title text NOT NULL,rdate text NOT NULL,rtime text NOT NUll,isrepeated bool NOT NUll,status bool NOT NUll,repetition_time String,pic String )");
    print("Created tables");
  }

  void savereminder(Reminder reminder) async {
    var dbClient = await db;
    await dbClient?.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO reminder(r_title, rdate, rtime, isrepeated,status,repetition_time,pic ) VALUES(' +
              '\'' +
              reminder.title.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.date.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.time.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.isrepeated.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.status.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.repetitiontime.toString() +
              '\'' +
              ',' +
              '\'' +
              reminder.pic.toString() +
              '\'' +
              ')');
    });
  }

  Future<List<dynamic>> getreminder() async {
    var dbClient = await db;
    List<dynamic> list = await dbClient!.rawQuery('SELECT * FROM reminder');
    // List<Map> list = await dbClient!.rawQuery('SELECT * FROM reminder');
    // List<Reminder> reminder = [];
    // print(list);
    // for (int i = 0; i < list.length; i++) {
    //   reminder.add(Reminder(
    //       list[i]["r_title"],
    //       list[i]["rdate"],
    //       list[i]["rtime"],
    //       list[i]["isrepeated"],
    //       list[i]["status"],
    //       list[i]["repetition_time"].toString(),
    //       list[i]["pic"].toString()));
    // }
    print(list.length);
    print(list);
    return list;
  }

  void delete(int id) async {
    var dbClient = await db;
    await dbClient!.rawQuery('DELETE FROM reminder WHERE reminder_id = ${id}');
    print("deleted");
  }
}
