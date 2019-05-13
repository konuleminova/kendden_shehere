import 'package:kendden_shehere/data/model/shop_model.dart';

class RemoveShopItemAction {
  List<ShopItem> shopItems;
  ShopItem removeShopItem;
  RemoveShopItemAction({this.shopItems,this.removeShopItem});
}
