import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';

Reducer<HomeList> homeReducer = combineReducers<HomeList>([
  TypedReducer<HomeList, ShowAllCollectionAction>(showAllCollectionReducer),
]);

HomeList showAllCollectionReducer(
    HomeListstate, ShowAllCollectionAction action) {
  return action.homeList;
}
