import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/data/model/shop_item_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';

class RemoveShopItemAction {
  List<Product> shopItems;
  Product removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddProductAction {
  Product product;

  AddProductAction({this.product});
}
