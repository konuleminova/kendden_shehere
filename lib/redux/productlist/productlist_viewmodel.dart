import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:kendden_shehere/redux/search/search_thunk.dart';
import 'package:kendden_shehere/redux/shoplist/shopList_thunk.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_thunk.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id, String lang, String limit, String page, String order)
      onFetchProductList;
  List<NewProduct> productList;
  Function(String order) changeOrder;
  String order;
  Function(String id, String lang, String limit, String page, String order)
      onLoadMoreProductList;
  Function(String id, String lang, String limit, String page, String order)
      onChangeProductList;
  Function(int index, bool isLiked) changeStatus;
  Function(int index, bool isAdded, int weight) changeAddStatus;
  List<NewProduct> shopList;
  Function() onFetchShopList;
  List<NewProduct> wishList;
  Function() onFetchWishList;
  Function(NewProduct shopItem) addShopItem;
  Function(NewProduct shopItem) removeShopItem;
  Function(NewProduct shopItem) addWishItem;
  Function(NewProduct shopItem) removeWishItem;
  Function(String lang, String query) onSearchProductList;

  ProductListViewModel(
      {this.onFetchProductList,
      this.productList,
      this.changeOrder,
      this.order,
      this.onLoadMoreProductList,
      this.onChangeProductList,
      this.changeStatus,
      this.changeAddStatus,
      this.shopList,
      this.onFetchShopList,
      this.wishList,
      this.onFetchWishList,
      this.addShopItem,
      this.removeShopItem,
      this.addWishItem,
      this.removeWishItem,
      this.onSearchProductList});

  factory ProductListViewModel.create(Store<AppState> store) {
    _onFetchProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "init"));
    }

    _onLoadMoreProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "loadMore"));
    }

    _onChangeOrderProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "change"));
    }

    _onChangeStatusProductList(int index, bool isLiked) {
      store.dispatch(StatusAction(index, isLiked));
    }

    _onChangeAddStatusProductList(int index, bool isAdded, int weight) {
      store.dispatch(AddStatusAction(index, isAdded, weight));
    }

    _onFetchShopList() {
      store.dispatch(shopListThunkAction());
    }

    _onFetchWishList() {
      store.dispatch(wishListThunkAction());
    }

    _addShopItem(NewProduct product) {
      store.dispatch(AddProductAction(product: product));
    }

    _removeShopItem(NewProduct product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    _addWishItem(NewProduct product) {
      store.dispatch(AddWishItemAction(product: product));
    }

    _removeWishItem(NewProduct product) {
      store.dispatch(RemoveWishItemAction(removeWishItem: product));
    }

    _onSearchProductList(String lang, String query) {
      store.dispatch(searchListThunkAction(lang, query));
    }

    return ProductListViewModel(
        productList: store.state.newProducts,
        onFetchProductList: _onFetchProductList,
        onLoadMoreProductList: _onLoadMoreProductList,
        order: store.state.filterOrder,
        onChangeProductList: _onChangeOrderProductList,
        changeStatus: _onChangeStatusProductList,
        changeAddStatus: _onChangeAddStatusProductList,
        shopList: store.state.shopItems,
        // onFetchShopList: _onFetchShopList,
        wishList: store.state.wishItems,
        onFetchWishList: _onFetchWishList,
        addShopItem: _addShopItem,
        removeShopItem: _removeShopItem,
        addWishItem: _addWishItem,
        removeWishItem: _removeWishItem,
        onSearchProductList: _onSearchProductList);
  }
}
