import 'package:kendden_shehere/data/model/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';
import 'package:kendden_shehere/redux/action/shop_action.dart';

Reducer<List<ShopItem>> shopReducer = combineReducers<List<ShopItem>>([
  new TypedReducer<List<ShopItem>, RemoveShopItemAction>(removeShopItemReducer),
  new TypedReducer<List<ShopItem>, AddProductAction>(addCardReducer)
]);

List<ShopItem> removeShopItemReducer(
    List<ShopItem> shopItems, RemoveShopItemAction action) {
  return List.from(shopItems)..remove(action.removeShopItem);
}

List<ShopItem> addCardReducer(List<ShopItem> state, AddProductAction action) {
    return List.from(state)..add(action.product);
}
