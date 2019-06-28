import 'package:kendden_shehere/redux/login/new_user_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/data/model/login_model.dart';
import 'package:kendden_shehere/redux/login/login_action.dart';

Reducer<NewUserModel> loginReducer = combineReducers<NewUserModel>(
    [TypedReducer<NewUserModel, LoginAction>(signInReducer)]);

NewUserModel signInReducer(NewUserModel state, LoginAction action) {
  return state.copyWith(
      name: action.username,
      password: action.password,
      status: action.status,
      isLogin: action.isLogin);
}
