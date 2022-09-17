import '../Database/DBHelper.dart';
import '../Models/ReminderModel.dart';

class ReminderController {
  var dbHelper = DBHelper();
  addreminder(String title, String date, String time, String path,
      String repeat) async {
    var reminder =
        Reminder(title, date, time, repeat.toString(), "true", "5", path);
    dbHelper.savereminder(reminder);
  }

  Future<List<dynamic>> getreminder() async {
    List<dynamic> reminder = [];
    try {
      reminder = await dbHelper.getreminder();
    } catch (e) {
      throw Exception('Failed to load $e');
    }
    return reminder;
  }

  deletereminder(int id) {
    try {
      dbHelper.delete(id);
    } catch (e) {
      throw Exception("Failed To Delete");
    }
  }
}
