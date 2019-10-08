import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/redux/lang/lang_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/redux/home/thunk_home.dart';

class HomeViewModel {
  Function(String id) onFetchProductList;
  List<NewProduct>productList;
  Function(NewProduct product) addShopItem;
  Function(NewProduct shopItem) removeShopItem;
  Function(Product shopItem) removeWishItem;
  Function(Product product) addWishItem;
  Function(String lang) changeLang;

  HomeViewModel(
      {this.onFetchProductList,
      this.addShopItem,
      this.removeShopItem,
      this.addWishItem,
      this.removeWishItem,
      this.changeLang,this.productList});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchProductList(id) {
      store.dispatch(getProductListThunkAction(id));
    }

    _addShopItem(NewProduct product) {
      store.dispatch(AddProductAction(product: product));
    }

    _removeShopItem(NewProduct product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    _addWishItem(Product product) {
     // store.dispatch(AddWishItemAction(product: product));
    }

    _removeWishItem(Product product) {
    //  store.dispatch(RemoveWishItemAction(removeWishItem: product));
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
        changeLang: _changeLang,
    productList: store.state.homeProducts);
  }
}
