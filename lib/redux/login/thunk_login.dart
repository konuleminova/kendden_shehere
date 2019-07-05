import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/redux/navigation/navigator_action.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/login_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> loginThunkFunction(String username, String password) {
  return (Store<AppState> store) async {
    UserModel userLogin = new UserModel();
    userLogin.status = STATUS.LOADING;
    store.dispatch(LoginAction(status: STATUS.LOADING));
    UserModel responseBody = await Networks.login(username, password);
    if (responseBody != null) {
      userLogin.status = STATUS.SUCCESS;
      store.dispatch(LoginAction(status: STATUS.SUCCESS));
      userLogin.name =responseBody.name;
      userLogin.username=username;
      userLogin.surname = password;
      userLogin.mobile = responseBody.mobile;
      userLogin.address = responseBody.address;
      userLogin.isLogin = true;
      SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
      sharedPrefUtil.setBool(SharedPrefUtil.isLoginKey, userLogin.isLogin);
      sharedPrefUtil.setString(SharedPrefUtil.name, userLogin.name);
      sharedPrefUtil.setString(
          SharedPrefUtil.surname, userLogin.surname);
      sharedPrefUtil.setString(
          SharedPrefUtil.username, userLogin.username);
      sharedPrefUtil.setString(
          SharedPrefUtil.mobile, userLogin.mobile);
      store.dispatch(NavigateReplaceAction("/home"));
    } else {
      checkInternetConnection().then((onValue) {
        if (onValue) {
          userLogin.status = STATUS.FAIL;
          store.dispatch(LoginAction(status: STATUS.FAIL));
          showSnackBar("Username or password is wrong.", scaffoldKey);
        } else {
          userLogin.status = STATUS.NETWORK_ERROR;
          store.dispatch(LoginAction(status: STATUS.NETWORK_ERROR));
          showSnackBar("No internet connection.", scaffoldKey);
        }
      });
    }
  };
}
