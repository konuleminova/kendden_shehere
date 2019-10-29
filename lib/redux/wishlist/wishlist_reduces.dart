import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<Product>> wishListReducer = combineReducers<List<Product>>([
  new TypedReducer<List<Product>, FetchWishListAction>(fetchWishListAction),
  new TypedReducer<List<Product>, RemoveWishItemAction>(removeWishItemReducer),
  new TypedReducer<List<Product>, AddWishItemAction>(addWishItemReducer),
]);

List<Product> removeWishItemReducer(
    List<Product> state, RemoveWishItemAction action) {
  return List.from(state)..remove(action.removeWishItem);
}

List<Product> addWishItemReducer(
    List<Product> state, AddWishItemAction action) {
  return List.from(state)..add(action.product);
}

List<Product> fetchWishListAction(
    List<Product> state, FetchWishListAction action) {
  action.data.forEach((f) {
    f.isLiked = true;
  });
  return action.data;
}
