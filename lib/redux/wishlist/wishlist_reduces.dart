import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

Reducer<List<NewProduct>> wishListReducer = combineReducers<List<NewProduct>>([
  new TypedReducer<List<NewProduct>, RemoveWishItemAction>(
      removeWishItemReducer),
  new TypedReducer<List<NewProduct>, AddWishItemAction>(addWishItemReducer),
  new TypedReducer<List<NewProduct>, FetchWishListAction>(fetchWishListAction),
]);

List<NewProduct> removeWishItemReducer(
    List<NewProduct> shopItems, RemoveWishItemAction action) {
  return List.from(shopItems)..remove(action.removeWishItem);
}

List<NewProduct> addWishItemReducer(
    List<NewProduct> state, AddWishItemAction action) {
  return List.from(state)..add(action.product);
}

List<NewProduct> fetchWishListAction(
    List<NewProduct> state, FetchWishListAction action) {
  return []..addAll(action.data);
}
