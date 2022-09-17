import 'dart:convert';
import 'dart:io';

import 'package:birthday_app_new/Controller/Constants.dart';
import 'package:http/http.dart' as http;

class  GreetingCardController {
  Future<List<dynamic>> getgreetingcategory() async {
    String url = "http://134.209.195.127/json/BDay-Category.json";
    List<dynamic> cards = [];
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        cards = jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return cards;
  }

  Future<List<dynamic>> getgreetingsubcategory() async {
    List<dynamic> subcards = [];
    var response;
    try {
      response = await http.get(Uri.parse(Constants.cakesCategory));
      if (response.statusCode == 200) {
        subcards = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return subcards;
  }

  Future<List<dynamic>> generalcategory() async {
    ;
    List<dynamic> gcards = [];
    try {
      var response = await http.get(Uri.parse(Constants.generalwcakeurl));
      if (response.statusCode == 200) {
        gcards = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return gcards;
  }

  Future<List<dynamic>> getgreetingsubcategorywocake() async {
    List<dynamic> subcards = [];
    var response;
    try {
      response = await http.get(Uri.parse(Constants.cardsCategory));
      if (response.statusCode == 200) {
        subcards = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return subcards;
  }

  Future<List<dynamic>> generalcategorywocake() async {
    ;
    List<dynamic> gcards = [];
    try {
      var response = await http.get(Uri.parse(Constants.generalwocakeurl));
      if (response.statusCode == 200) {
        gcards = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load $e');
    }
    return gcards;
  }
}
