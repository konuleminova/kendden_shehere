import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<Product>> productListReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, FetchProductListAction>(fetchProductListReducer),
  TypedReducer<List<Product>, LoadMoreProductListAction>(
      loadMoreProductListReducer),
  TypedReducer<List<Product>, ShowBasketAction>(showBasketProductListReducer),
  TypedReducer<List<Product>, ShowWishAction>(showwishProductListReducer),
]);

List<Product> fetchProductListReducer(
    List<Product> state, FetchProductListAction action) {
  state.clear();
  List<Product> tempList = new List();
  print(action.data.toString() + "actionn data");
  for (int i = 0; i < action.data.length; i++) {
    tempList.add(action.data[i]);
  }
  state.addAll(tempList);

  return state;
}

List<Product> loadMoreProductListReducer(
    List<Product> state, LoadMoreProductListAction action) {
  if (action.data.length > 0) {
    state.addAll(action.data);
    return state;
  }
  return state;
}

List<Product> showBasketProductListReducer(
    List<Product> state, ShowBasketAction action) {
  action.store.state.newProducts.forEach((item) {
    action.store.state.shopItems.forEach((f) {
      if (item.id == f.id) {
        item.isAdded = true;
        item.weight = f.weight;
      }
    });
  });
  return state;
}

List<Product> showwishProductListReducer(
    List<Product> state, ShowWishAction action) {
  action.store.state.newProducts.forEach((item) {
    action.store.state.wishItems.forEach((f) {
      if (item.id == f.id) {
        item.isLiked = true;
      }
    });
  });
  return state;
}
