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
import 'package:fluttertoast/fluttertoast.dart';

ThunkAction<AppState> loginThunkFunction(String username, String password) {
  return (Store<AppState> store) async {
    UserModel userLogin = new UserModel();
    userLogin.status = STATUS.LOADING;
    store.dispatch(LoginAction(status: STATUS.LOADING));
    UserModel responseBody = await Networks().login(username, password);
    if (responseBody != null) {
      userLogin.status = STATUS.SUCCESS;
      userLogin.isLogin=true;
      store.dispatch(LoginAction(status: STATUS.SUCCESS));
      SharedPrefUtil().setBool(SharedPrefUtil().isLoginKey, userLogin.isLogin);
      SharedPrefUtil().setString(SharedPrefUtil().name, responseBody.name);
      SharedPrefUtil().setString(SharedPrefUtil().surname, responseBody.surname);
      SharedPrefUtil().setString(SharedPrefUtil().username, username);
      SharedPrefUtil().setString(SharedPrefUtil().mobile, responseBody.mobile);
      SharedPrefUtil().setString(SharedPrefUtil().uid, responseBody.id);
      store.dispatch(NavigateReplaceAction("/home"));
    } else {
      store.dispatch(NavigateReplaceAction("/pin_code"));
      checkInternetConnection().then((onValue) {
        if (onValue) {
          userLogin.status = STATUS.FAIL;
          store.dispatch(LoginAction(status: STATUS.FAIL));
          Fluttertoast.showToast(
              msg: "Username or password is wrong.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
         // showSnackBar("Username or password is wrong.", scaffoldKey);
        } else {
          userLogin.status = STATUS.NETWORK_ERROR;
          store.dispatch(LoginAction(status: STATUS.NETWORK_ERROR));
          Fluttertoast.showToast(
              msg: "No internet connection.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          //showSnackBar("No internet connection.", scaffoldKey);
        }
      });
    }
  };
}
