import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/newmodel/new_user_model.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/navigation/navigator_action.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:kendden_shehere/redux/action/login_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> loginThunkFunction(String username, String password) {
  return (Store<AppState> store) async {
    NewUserModel userLogin = new NewUserModel();
    userLogin.status = STATUS.LOADING;
    store.dispatch(LoginAction(status: STATUS.LOADING));
    NewUserModel responseBody = await Networks.login(username, password);
    print(responseBody.toString());
    print(responseBody.toString() + "..");
    print("konul");
    if (responseBody != null) {
      print("not null");
      userLogin.name = username;
      userLogin.surname = password;
      userLogin.email = responseBody.email;
      userLogin.mobile = responseBody.mobile;
      userLogin.address = responseBody.address;
      userLogin.isLogin = true;
      userLogin.status = STATUS.SUCCESS;
      SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
      sharedPrefUtil.setUserHasLogin(userLogin.isLogin);
      store.dispatch(NavigateReplaceAction("/home"));
    } else {
      checkInternetConnection().then((onValue) {
        if (onValue) {
          showSnackBar("Username or password is wrong.");
        }else{
          showSnackBar("No internet connection.");
        }
      });
      userLogin.status = STATUS.FAIL;
      store.dispatch(LoginAction(status: STATUS.FAIL));
    }
    /* if (responseBody != null) {
      userLogin.name = username;
      userLogin.surname = password;
      userLogin.email = responseBody.email;
      userLogin.mobile = responseBody.mobile;
      userLogin.address = responseBody.address;
      userLogin.isLogin = true;
      userLogin.status = STATUS.SUCCESS;
      SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
      sharedPrefUtil.setUserHasLogin(userLogin.isLogin);
      store.dispatch(LoginAction(
          username: username,
          password: password,
          isLogin: true,
          status: STATUS.SUCCESS));
    } else {
      userLogin.status = STATUS.FAIL;
      store.dispatch(LoginAction(status: STATUS.FAIL));
    }
    */
  };
}
