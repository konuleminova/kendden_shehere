import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/login/login_action.dart';

Reducer<UserModel> loginReducer = combineReducers<UserModel>(
    [TypedReducer<UserModel, LoginAction>(signInReducer)]);

UserModel signInReducer(UserModel state, LoginAction action) {
  return state.copyWith(
      name: action.username,
      password: action.password,
      status: action.status,
      isLogin: action.isLogin);
}
