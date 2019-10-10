import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<NewProduct>> productListReducer =
    combineReducers<List<NewProduct>>([
  TypedReducer<List<NewProduct>, FetchProductListAction>(
      fetchProductListReducer),
  TypedReducer<List<NewProduct>, LoadMoreProductListAction>(
      loadMoreProductListReducer),
  TypedReducer<List<NewProduct>, StatusAction>(statusReducer),
  TypedReducer<List<NewProduct>, AddStatusAction>(addStatusReducer),
]);

List<NewProduct> fetchProductListReducer(
    List<NewProduct> state, FetchProductListAction action) {
  state.clear();
  List<NewProduct> tempList = new List();
  //tempList.addAll(action.data);
  print(action.data.toString() + "actionn data");
  for (int i = 0; i < action.data.length; i++) {
    if (action.data[i].hasphoto == "1") {
      tempList.add(action.data[i]);
    }
  }
  state.addAll(tempList);
  return state;
}

List<NewProduct> loadMoreProductListReducer(
    List<NewProduct> state, LoadMoreProductListAction action) {
  //state.clear();
  List<NewProduct> tempList = new List();
  //tempList.addAll(action.data);
  print(action.data.toString() + "actionn data");
  for (int i = 0; i < action.data.length; i++) {
    if (action.data[i].hasphoto == "1") {
      tempList.add(action.data[i]);
    }
  }
  print("LOADDD ACTION");
  print(action.data);
  if (action.data.length > 0) {
    print("Load not");
    print(action.data);
    print(state);
    state.addAll(tempList);
    return state;
  } else {
    tempList.clear();
    state.addAll(tempList);
    return state;
  }
////  state.addAll(tempList);
//  return state;
}

List<NewProduct> statusReducer(List<NewProduct> state, StatusAction action) {
  List<NewProduct> states = state;
  states[action.index].isLiked = action.isLiked;
  return states;
}

List<NewProduct> addStatusReducer(
    List<NewProduct> state, AddStatusAction action) {
  List<NewProduct> states = state;
  states[action.index].isAdded = action.isAdded;
  states[action.index].weight = action.weight;
  return states;
}
