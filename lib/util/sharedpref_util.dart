import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
   static String isLoginKey = "User has login";
   static String setUserName = "User name";
   static String setUserSurname = "User surname";

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
