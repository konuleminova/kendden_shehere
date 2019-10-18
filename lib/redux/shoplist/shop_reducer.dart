import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

Reducer<List<Product>> shopReducer = combineReducers<List<Product>>([
  new TypedReducer<List<Product>, AddShopItemAction>(addShopItemReducer),
  new TypedReducer<List<Product>,FetchShopListAction>(fetchShopListAction),
  new TypedReducer<List<Product>, RemoveShopItemAction>(removeShopItemReducer),

]);

List<Product> removeShopItemReducer(
    List<Product> shopItems, RemoveShopItemAction action) {
  return shopItems..remove(action.removeShopItem);
}

List<Product> addShopItemReducer(List<Product> state, AddShopItemAction action) {
  return List.from(state)..add(action.product);
}

List<Product> fetchShopListAction(
    List<Product> state, FetchShopListAction action) {
  return action.data;
}
