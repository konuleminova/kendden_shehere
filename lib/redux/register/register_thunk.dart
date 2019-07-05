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
    print('RESPONSE IS NOT NULL: ${responseBody != null}');
    print('MSUCCESS: ${responseBody.msuccess}');
    try {
      if(responseBody != null) {
        if (responseBody.msuccess != '1') {
          checkInternetConnection().then((onValue) {
            if (onValue) {
              userLogin.status = STATUS.FAIL;
              store.dispatch(LoginAction(status: STATUS.FAIL));
              if(responseBody.login.error!="no-error"){
                showSnackBar(responseBody.login.error, scaffoldRegisterKey);
              }else
              if(responseBody.pass.error!="no-error"){
                showSnackBar(responseBody.pass.error, scaffoldRegisterKey);
              }else
              if(responseBody.mobile.error!="no-error"){
                showSnackBar(responseBody.mobile.error, scaffoldRegisterKey);
              }
              if(responseBody.name.error!="no-error"){
                showSnackBar(responseBody.name.error, scaffoldRegisterKey);
              }else
              if(responseBody.surname.error!="no-error"){
                showSnackBar(responseBody.surname.error, scaffoldRegisterKey);
              }
              //showSnackBar(responseBody.toString(), scaffoldRegisterKey);
            } else {
              userLogin.status = STATUS.NETWORK_ERROR;
              store.dispatch(LoginAction(status: STATUS.NETWORK_ERROR));
              showSnackBar("No internet connection.", scaffoldRegisterKey);
            }
          });
        } else {
          userLogin.status = STATUS.SUCCESS;
          store.dispatch(LoginAction(status: STATUS.SUCCESS));
          userLogin.isLogin = true;
          SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
          sharedPrefUtil.setBool(SharedPrefUtil.isLoginKey, userLogin.isLogin);
          sharedPrefUtil.setString(SharedPrefUtil.name, userModel.name);
          sharedPrefUtil.setString(SharedPrefUtil.surname, userModel.surname);
          sharedPrefUtil.setString(SharedPrefUtil.username, userModel.username);
          sharedPrefUtil.setString(SharedPrefUtil.mobile, userModel.mobile);
        //  sharedPrefUtil.setString(SharedPrefUtil.id, responseBody.id);
          store.dispatch(NavigateReplaceAction("/home"));
          store.state.user_info = userModel;
        }
      }
    } catch (e) {}
  };
}
