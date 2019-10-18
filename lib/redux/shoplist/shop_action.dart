import 'package:kendden_shehere/redux/productlist/product_model.dart';

class RemoveShopItemAction {
  List<Product> shopItems;
 Product removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddShopItemAction {
  Product product;

  AddShopItemAction({this.product});
}
class FetchShopListAction {
  List<Product> data;
  FetchShopListAction({this.data});
}
