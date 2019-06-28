import 'package:kendden_shehere/redux/data/viewmodel/wishlist_viewmodel.dart';
import 'package:kendden_shehere/redux/action/lang_action.dart';
import 'package:kendden_shehere/redux/action/wishlist_action.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/action/shop_action.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/data/model/app_state_model.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/redux/action/home_action.dart';
import 'package:kendden_shehere/redux/middleware/thunk_home.dart';

class HomeViewModel {
  Function(int limit, int page) onFetchProductList;
  Function(Product product) addShopItem;
  Function(Product shopItem) removeShopItem;
  Function(Product shopItem) removeWishItem;
  Function(Product product) addWishItem;
  List<Product> wishItems;
  Function(String lang) changeLang;

  HomeViewModel(
      {this.onFetchProductList,
      this.addShopItem,
      this.removeShopItem,
      this.addWishItem,
      this.removeWishItem,
      this.changeLang});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchProductList(int limit, int page) {
      store.dispatch(getProductListThunkAction(limit, page));
    }

    _addShopItem(Product product) {
      store.dispatch(AddProductAction(product: product));
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

    _changeLang(String lang) {
      store.dispatch(ChangeLangAction(lang: lang));
    }

    return HomeViewModel(
        onFetchProductList: _onFetchProductList,
        addShopItem: _addShopItem,
        removeShopItem: _removeShopItem,
        addWishItem: _addWishItem,
        removeWishItem: _removeWishItem,
        changeLang: _changeLang);
  }
}
