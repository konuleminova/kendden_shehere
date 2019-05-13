import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:kendden_shehere/redux/action/login_action.dart';

Reducer<UserLogin> loginReducer = combineReducers<UserLogin>(
    [TypedReducer<UserLogin, LoginAction>(signInReducer)]);

UserLogin signInReducer(UserLogin state, LoginAction action) {
  return state.copyWith(
      username: action.username,
      password: action.password,
      status: action.status,
      isLogin: action.isLogin);
}
