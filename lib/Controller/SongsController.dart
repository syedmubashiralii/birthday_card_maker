import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Songslistcontroller {
  Future<List<dynamic>> getsongs() async {
    String url = "http://134.209.195.127/json/BDay-Songs.json";
    List<dynamic> songs = [];
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        songs = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return songs;
  }
}
