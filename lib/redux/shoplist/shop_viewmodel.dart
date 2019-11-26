import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shopList_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

class ShoppingCartViewModel {
  Function(Product shopItem) removeShopItem;
  List<Product> shopItems;
  Function() onFetchShopList;
  Function(bool isDelete) isDelete;

  ShoppingCartViewModel(
      {this.removeShopItem,
      this.shopItems,
      this.onFetchShopList,
      this.isDelete});

  factory ShoppingCartViewModel.create(Store<AppState> store) {
    _removeShopItem(Product product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    _onFetchShopList() {
      store.dispatch(shopListThunkAction());
    }

    _isDelete(bool delete) {
      store.dispatch(DeleteShopListAction(delete: true));
    }

    return ShoppingCartViewModel(
        removeShopItem: _removeShopItem,
        shopItems: store.state.shopItems,
        onFetchShopList: _onFetchShopList,
        isDelete: _isDelete);
  }
}
