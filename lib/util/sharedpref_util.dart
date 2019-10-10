import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  SharedPrefUtil._privateConstructor();

  static final SharedPrefUtil _instance = SharedPrefUtil._privateConstructor();

  factory SharedPrefUtil() {
    return _instance;
  }

  String isLoginKey = "User has login";
  String name = "name";
  String surname = "surname";
  String username = "username";
  String mobile = "mobile";
  String uid = "User id";
  String id = "Product id";
  String lang = "lang";
  String count = "count";
  String alkaqol = "alkaqol";
  String address = "Address";
  String coordinates = "Coordinates";
  String lat = "lat";
  String lng = "lng";
  String price = "price";

  Future<bool> getBool(String key) async {
    // sleep(const Duration(seconds:5));
    await Future.delayed(Duration(milliseconds: 2000));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  setBool(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }

  Future<String> getString(String key) async {
    // sleep(const Duration(seconds:5));
    //await Future.delayed(Duration(milliseconds: 2000));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? "";
  }

  setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }
}
