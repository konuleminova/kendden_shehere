import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';

class RemoveShopItemAction {
  List<Product> shopItems;
  Product removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddProductAction {
  Product product;

  AddProductAction({this.product});
}
