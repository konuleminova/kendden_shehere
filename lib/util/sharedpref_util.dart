import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
   static String isLoginKey = "User has login";
   static String name = "name";
   static String surname = "surname";
   static String username = "username";
   static String mobile = "mobile";
   static String uid = "User id";
   static String id = "Product id";
   static String lang = "lang";
   static String count="count";

  static String alkaqol="alkaqol";

  static String address="Address";
   static String coordinates="Coordinates";

  static String lat="lat";
   static String lng="lng";
  Future<bool> getBool(String key) async {
    // sleep(const Duration(seconds:5));
    await Future.delayed(Duration(milliseconds: 2000));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  setBool(String key,bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }
   Future<String> getString(String key) async {
     // sleep(const Duration(seconds:5));
     //await Future.delayed(Duration(milliseconds: 2000));
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     return sharedPreferences.getString(key) ?? "";
   }

   setString(String key,String value) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.setString(key, value);
   }

}
