import 'package:kendden_shehere/redux/productlist/new_product_model.dart';

class RemoveShopItemAction {
  List<NewProduct> shopItems;
 NewProduct removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddProductAction {
  NewProduct product;

  AddProductAction({this.product});
}
class FetchShopListAction {
  List<NewProduct> data;
  FetchShopListAction({this.data});
}
