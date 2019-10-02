import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';

class RemoveShopItemAction {
  List<NewProduct> shopItems;
 NewProduct removeShopItem;

  RemoveShopItemAction({this.shopItems, this.removeShopItem});
}

class AddProductAction {
  NewProduct product;

  AddProductAction({this.product});
}
