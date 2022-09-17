// import 'package:sqflite/sqflite.dart';
// class DBHandler
// {
//   Database? _db;
// static DBHandler? _instance=null;
// int dbversion=1;
// DBHandler._Init() 
// {
//  _createDB();
// }

// Future<void> _createDB() async
// { 

//  if(_db==null){
//  print('getting db path');
//  String dbpath= await getDatabasesPath().timeout(Duration(seconds: 20));
// dbpath=dbpath+"test.db";
//  print("DB Path "+dbpath);
//  _db=await openDatabase(dbpath,version: 1,
// onCreate: (Database db, int version) async {
//  print('Creating table student');
//  String query=
// '''
// create table student(id integer primary key,name text)
// ''';
// await db.execute(query).then((value) => print("Sccussfully initialized"));
// });

// }
// }

// static Future<DBHandler> getInstnace() async
// {
//  //  String ?s;
//  //  String s1=s ?? "";
// if(_instance==null)
// _instance=DBHandler._Init();

// return _instance!;
// }

// Future<void> insertData(int id,String name)async
// {
// print('Executing insertion command...');
// await _db!.rawInsert("insert into Student values ('$id','$name')");
// print('Command executed');
// }

// Future<void> insertDataObject(Student std)async
// {
// print('Executing insertion command...');
// await _db!.insert('student',std.toMap());
// print('Command executed');

// }
// Future<List<Map<String,dynamic>>> getData() async
// {
// print('Executing select command...');
//  var result=await _db!.rawQuery("select * from student");
//  print('Select command executed...');
// return result;
//  }
// Future<List<Student>> getStudentList() async
// {
//  List<Student> std=[];
//  print('Executing select command...');
// var result=await _db!.rawQuery("select * from student");
// print('Select command executed...');
// result.forEach((element) {
//  std.add(Student.fromMap(element));
//  });
//  return std;
// }

// }

// class Student
// {
//  late int id;
//  late String name;
//  Student(this.id,this.name);

//  Map<String,dynamic> toMap()
//  {
//  Map<String,dynamic> mp=Map();
//  mp["id"]=id;
//  mp["name"]=name;
//  return mp;
// }

// Student.fromMap(Map<String,dynamic> mp)
// {
//  id=mp["id"];
// name=mp["name"];

// }

// }
