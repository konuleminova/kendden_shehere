import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

class ShoppingCartViewModel {
  Function(Product shopItem) removeShopItem;
  List<Product> shopItems;

  ShoppingCartViewModel({this.removeShopItem, this.shopItems});

  factory ShoppingCartViewModel.create(Store<AppState> store) {
    _removeShopItem(Product product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    return ShoppingCartViewModel(
        removeShopItem: _removeShopItem, shopItems: store.state.shopItems);
  }
}
