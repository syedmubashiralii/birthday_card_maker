
import 'dart:convert';
import 'dart:io';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:http/http.dart' as http;

class InvitationController {
  Future<List<dynamic>> getinvitationcategory() async {
    String url ="http://134.209.195.127/json/invitations.json";
    List<dynamic> cards = [];
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        cards = jsonDecode(response.body);
      }
      else
      {
        throw Exception('Failed to load');
      }
    }  on SocketException catch (e) {
    throw Exception('Failed to load $e');
  }
    return cards;
  }

    Future<List<dynamic>> getinvitationsubcategory() async {
    List<dynamic> subcards = [];
    try {
      var response = await http.get(Uri.parse(Constants.SubCategoryurl));
      if (response.statusCode == 200) {
        subcards = jsonDecode(response.body);
      }
      else
      {
        throw Exception('Failed to load');
      }
    }  on SocketException catch (e) {
    throw Exception('Failed to load $e');
  }
    return subcards;
  }
}
