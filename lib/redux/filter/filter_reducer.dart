import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/filter/filter_action.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/lang/lang_action.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/login/login_action.dart';

Reducer<String> filterReducer = combineReducers<String>(
    [TypedReducer<String,  ChangeFilterOrderAction>(filterInReducer)]);

String filterInReducer(String state,  ChangeFilterOrderAction action) {
  state=action.order;
  return state;
}