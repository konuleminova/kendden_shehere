import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/redux/navigation/navigator_action.dart';
import 'package:kendden_shehere/redux/register/register_model.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/login_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> registerThunkFunction(String lang, UserModel userModel) {
  return (Store<AppState> store) async {
    UserModel userLogin = new UserModel();
    userLogin.status = STATUS.LOADING;
    store.dispatch(LoginAction(status: STATUS.LOADING));
    RegisterModel responseBody = await Networks.register(lang, userModel);
    try {
      if (responseBody.msuccess == "1") {
        userLogin.status = STATUS.SUCCESS;
        store.dispatch(LoginAction(status: STATUS.SUCCESS));
//      userLogin.name = userModel.name;
//      userLogin.surname = userModel.surname;
//      userLogin.username = userModel.username;
//      userLogin.mobile = userModel.mobile;
//      userLogin.password = userModel.password;
        userLogin.isLogin = true;
        SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
        sharedPrefUtil.setUserHasLogin(userLogin.isLogin);
        store.dispatch(NavigateReplaceAction("/home"));
        store.state.user_info = userModel;
      } else {
        checkInternetConnection().then((onValue) {
          if (onValue) {
            userLogin.status = STATUS.FAIL;
            store.dispatch(LoginAction(status: STATUS.FAIL));
            showSnackBar(responseBody.toString(), scaffoldRegisterKey);
          } else {
            userLogin.status = STATUS.NETWORK_ERROR;
            store.dispatch(LoginAction(status: STATUS.NETWORK_ERROR));
            showSnackBar("No internet connection.", scaffoldRegisterKey);
          }
        });
      }
    } catch (e) {}
  };
}
