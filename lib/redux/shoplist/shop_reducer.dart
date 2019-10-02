import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

Reducer<List<NewProduct>> shopReducer = combineReducers<List<NewProduct>>([
  new TypedReducer<List<NewProduct>, RemoveShopItemAction>(removeShopItemReducer),
  new TypedReducer<List<NewProduct>, AddProductAction>(addCardReducer)
]);

List<NewProduct> removeShopItemReducer(
    List<NewProduct> shopItems, RemoveShopItemAction action) {
  return List.from(shopItems)..remove(action.removeShopItem);
}

List<NewProduct> addCardReducer(List<NewProduct> state, AddProductAction action) {
  return List.from(state)..add(action.product);
}
