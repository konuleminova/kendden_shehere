import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';
import 'package:kendden_shehere/redux/action/shop_action.dart';

class ShoppingCartViewModel {
  Function(ShopItem shopItem) removeShopItem;
  List<ShopItem> shopItems;

  ShoppingCartViewModel({this.removeShopItem,this.shopItems});

  factory ShoppingCartViewModel.create(Store<AppState> store) {
    _removeItem(ShopItem shopItem) {
      store.dispatch(RemoveShopItemAction(removeShopItem: shopItem));
    }
    return ShoppingCartViewModel(removeShopItem: _removeItem,shopItems: store.state.shopItems);
  }
}
