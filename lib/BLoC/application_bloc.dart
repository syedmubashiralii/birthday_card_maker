import 'dart:typed_data';
import 'package:birthday_app_new/Controller/ReminderController.dart';
import 'package:birthday_app_new/Controller/SongsController.dart';
import 'package:birthday_app_new/Controller/greetingcardcontroller.dart';
import 'package:birthday_app_new/Controller/invitationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:sticker_view/stickerview.dart';

import '../Controller/Constants.dart';

class ApplicationBloc with ChangeNotifier {
  Songslistcontroller slc = Songslistcontroller();
  ReminderController rc = ReminderController();
  InvitationController ic = InvitationController();
  GreetingCardController gcc = GreetingCardController();

  bool loading = true;
  bool editorloading = true;

  editorload() {
    editorloading = false;
    notifyListeners();
  }

  Future<List<dynamic>> getsongs() async {
    loading = true;
    notifyListeners();
    List<dynamic> songs = await slc.getsongs();
    loading = false;
    notifyListeners();
    return songs;
  }

  Future<List<dynamic>> getinvitationcategory() async {
    loading = true;
    notifyListeners();
    List<dynamic> cards = await ic.getinvitationcategory();
    loading = false;
    notifyListeners();
    return cards;
  }

  Future<List<dynamic>> getgreetingcategory() async {
    loading = true;
    notifyListeners();
    List<dynamic> cards = await gcc.getgreetingcategory();
    loading = false;
    notifyListeners();
    return cards;
  }

  Future<List<dynamic>> getinvitationsubcategory() async {
    loading = true;
    notifyListeners();
    List<dynamic> subcards = await ic.getinvitationsubcategory();
    loading = false;
    notifyListeners();
    return subcards;
  }

  Future<List<dynamic>> getgreetingsubcatregory() async {
    loading = true;
    notifyListeners();
    List<dynamic> subcards = await gcc.getgreetingsubcategory();
    List<dynamic> general = await gcc.generalcategory();
    loading = false;
    notifyListeners();
    return subcards + general;
  }

  Future<List<dynamic>> getgreetingsubcatregorywocake() async {
    loading = true;
    notifyListeners();
    List<dynamic> subcards = await gcc.getgreetingsubcategorywocake();
    List<dynamic> general = await gcc.generalcategorywocake();
    loading = false;
    notifyListeners();
    return subcards + general;
  }

  Future addreminder(String title, String date, String time, String path,
      String repeat) async {
    loading = true;
    notifyListeners();
    await rc.addreminder(title, date, time, path, repeat);
    loading = false;
    notifyListeners();
  }

  Future<List<dynamic>> getreminders() async {
    loading = true;
    notifyListeners();
    List<dynamic> reminder = await rc.getreminder();
    loading = false;
    notifyListeners();
    return reminder;
  }

  deletereminder(int id) async {
    loading = true;
    notifyListeners();
    await rc.deletereminder(id);
    loading = false;
    notifyListeners();
  }

  updatestickers(String sticker) async {
    Constants.stickerlist.add(
      Sticker(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: false,
        child: Image.network(sticker),
      ),
    );
    notifyListeners();
  }

  updateframe(Uint8List? frame) async {
    Constants.stickerlist.add(
      Sticker(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: false,
        child: Image.memory(frame!),
      ),
    );
    notifyListeners();
  }

  updatetext(String text, Color color) async {
    Constants.stickerlist.add(
      Sticker(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        isText: true,
        child: Text(
          text,
          style: TextStyle(color: color, fontFamily: Constants.fontfamily),
        ),
      ),
    );
    notifyListeners();
  }
}

class LanguageController extends ChangeNotifier {
  onLanguageChanged() async {
    await Future.delayed(Duration(milliseconds: 1000));
    notifyListeners();
  }
}
