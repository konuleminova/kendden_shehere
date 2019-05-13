import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:kendden_shehere/redux/action/login_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> loginThunkFunction(String username, String password) {
  return (Store<AppState> store) async {
    UserLogin userLogin = new UserLogin();
    userLogin.status = STATUS.LOADING;
    store.dispatch(LoginAction(status: STATUS.LOADING));
    AppState responseBody = await Networks.loginUser(username, password);
    print(responseBody.toString()+"..");
    if (responseBody != null) {
      if (responseBody.code == 1001) {
        userLogin.username = username;
        userLogin.password = password;
        userLogin.isLogin = true;
        userLogin.status = STATUS.SUCCESS;
        SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
        sharedPrefUtil.setUserHasLogin(userLogin.isLogin);
        store.dispatch(LoginAction(username: username,password: password,isLogin: true,status: STATUS.SUCCESS));
      } else {
        userLogin.status = STATUS.FAIL;
        store.dispatch(LoginAction(status: STATUS.FAIL));
      }
    } else {
      userLogin.status = STATUS.NETWORK_ERROR;
      store.dispatch(LoginAction(status: STATUS.NETWORK_ERROR));
    }
  };
}
