import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

Reducer<List<Product>> wishListReducer = combineReducers<List<Product>>([
  new TypedReducer<List<Product>, RemoveWishItemAction>(removeWishItemReducer),
  new TypedReducer<List<Product>, AddWishItemAction>(addWishItemReducer)
]);

List<Product> removeWishItemReducer(
    List<Product> shopItems, RemoveWishItemAction action) {
  return List.from(shopItems)..remove(action.removeWishItem);
}

List<Product> addWishItemReducer(
    List<Product> state, AddWishItemAction action) {
  return List.from(state)..add(action.product);
}
