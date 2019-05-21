import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/data/model/shop_item_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';

class RemoveShopItemAction {
  List<ShopItem> shopItems;
  ShopItem removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddProductAction {
  ShopItem product;

  AddProductAction({this.product});
}
