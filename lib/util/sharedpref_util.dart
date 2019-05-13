import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  final String isLoginKey = "User has login";

  Future<bool> getUserHasLogin() async {
    // sleep(const Duration(seconds:5));
    await Future.delayed(Duration(milliseconds: 2000));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isLoginKey) ?? false;
  }

  setUserHasLogin(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isLoginKey, value);
  }
}
