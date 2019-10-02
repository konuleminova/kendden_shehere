import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shopList_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

class ShoppingCartViewModel {
  Function(NewProduct shopItem) removeShopItem;
  List<NewProduct> shopItems;
  Function() onFetchShopList;

  ShoppingCartViewModel(
      {this.removeShopItem, this.shopItems, this.onFetchShopList});

  factory ShoppingCartViewModel.create(Store<AppState> store) {
    _removeShopItem(NewProduct product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    _onFetchShopList() {
      store.dispatch(shopListThunkAction());
    }

    return ShoppingCartViewModel(
        removeShopItem: _removeShopItem,
        shopItems: store.state.shopItems,
        onFetchShopList: _onFetchShopList);
  }
}
