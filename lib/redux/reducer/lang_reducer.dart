import 'package:kendden_shehere/redux/data/model/app_state_model.dart';
import 'package:kendden_shehere/redux/data/model/newmodel/new_user_model.dart';
import 'package:kendden_shehere/redux/action/lang_action.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/data/model/login_model.dart';
import 'package:kendden_shehere/redux/action/login_action.dart';

Reducer<String> langReducer = combineReducers<String>(
    [TypedReducer<String, ChangeLangAction>(langInReducer)]);

String langInReducer(String state, ChangeLangAction action) {
  state=action.lang;
  return state;
}
