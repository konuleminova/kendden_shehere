import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

Reducer<List<Product>> shopReducer = combineReducers<List<Product>>([
  new TypedReducer<List<Product>, RemoveShopItemAction>(removeShopItemReducer),
  new TypedReducer<List<Product>, AddProductAction>(addCardReducer)
]);

List<Product> removeShopItemReducer(
    List<Product> shopItems, RemoveShopItemAction action) {
  return List.from(shopItems)..remove(action.removeShopItem);
}

List<Product> addCardReducer(List<Product> state, AddProductAction action) {
  return List.from(state)..add(action.product);
}
