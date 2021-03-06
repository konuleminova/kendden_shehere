import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:redux/redux.dart';

class ProductViewModel {
  Function(Product shopItem) addShopItem;
  Function(Product shopItem) removeShopItem;
  Function(Product shopItem) addWishItem;
  Function(Product shopItem) removeWishItem;
  List<Product> shopItems;
  bool isLoading;
  Function onHomeRefresh;
  bool isDelete;

  ProductViewModel(
      {this.addShopItem,
      this.removeShopItem,
      this.addWishItem,
      this.removeWishItem,
      this.shopItems,
      this.isLoading,
      this.onHomeRefresh,
      this.isDelete});

  factory ProductViewModel.create(Store<AppState> store) {
    _addShopItem(Product product) {
      store.dispatch(AddShopItemAction(product: product));
    }

    _removeShopItem(Product product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    _addWishItem(Product product) {
      store.dispatch(AddWishItemAction(product: product));
    }

    _removeWishItem(Product product) {
      store.dispatch(RemoveWishItemAction(removeWishItem: product));
    }

    _onHomeRefresh() {
      store.dispatch(ShowHomeWishAction(store));
      store.dispatch(ShowHomeBasketAction(store));
    }

    return ProductViewModel(
        addShopItem: _addShopItem,
        removeShopItem: _removeShopItem,
        addWishItem: _addWishItem,
        removeWishItem: _removeWishItem,
        shopItems: store.state.shopItems,
        isLoading: store.state.isLoading,
        onHomeRefresh: _onHomeRefresh,
        isDelete: store.state.isDelete);
  }
}
