import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<NewProduct>> productListReducer =
    combineReducers<List<NewProduct>>([
  TypedReducer<List<NewProduct>, FetchProductListAction>(
      fetchProductListReducer),
  TypedReducer<List<NewProduct>, LoadMoreProductListAction>(
      loadMoreProductListReducer),
  TypedReducer<List<NewProduct>, StatusAction>(likeStatusReducer),
  TypedReducer<List<NewProduct>, AddStatusAction>(addStatusReducer),
  TypedReducer<List<NewProduct>, ShowBasketAction>(
      showBasketProductListReducer),
      TypedReducer<List<NewProduct>, ShowWishAction>(
         showwishProductListReducer),
]);

List<NewProduct> fetchProductListReducer(
    List<NewProduct> state, FetchProductListAction action) {
  state.clear();
  //tempList.addAll(action.data);
  List<NewProduct> tempList = new List();
  print(action.data.toString() + "actionn data");
  for (int i = 0; i < action.data.length; i++) {
   tempList.add(action.data[i]);
  }
  state.addAll(tempList);

  return state;
}

List<NewProduct> loadMoreProductListReducer(
    List<NewProduct> state, LoadMoreProductListAction action) {
  //state.clear();
//  List<NewProduct> tempList = new List();
//  //tempList.addAll(action.data);
//  print(action.data.toString() + "actionn data");
//  for (int i = 0; i < action.data.length; i++) {
//    if (action.data[i].hasphoto == "1") {
//      tempList.add(action.data[i]);
//    }
//  }
  print("LOADDD ACTION");
  print(action.data);
  if (action.data.length > 0) {
    state.addAll(action.data);
    return state;
  }
////  state.addAll(tempList);
  return state;
}

List<NewProduct> likeStatusReducer(
    List<NewProduct> state, StatusAction action) {
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

List<NewProduct> showBasketProductListReducer(
    List<NewProduct> state, ShowBasketAction action) {
  action.store.state.newProducts.forEach((item) {
    action.store.state.shopItems.forEach((f) {
      if (item.id == f.id) {
        item.isAdded = true;
      }
    });
  });
  return state;
}
List<NewProduct> showwishProductListReducer(
    List<NewProduct> state, ShowWishAction action) {
  action.store.state.newProducts.forEach((item) {
    action.store.state.wishItems.forEach((f) {
      if (item.id == f.id) {
        item.isLiked = true;
      }
    });
  });
  return state;
}