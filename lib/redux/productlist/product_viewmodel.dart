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

class ProductViewModel {
  Function(int index, bool isLiked) changeLikeStatus;
  Function(int index, bool isAdded, int weight) changeAddStatus;
  Function(NewProduct shopItem) addShopItem;
  Function(NewProduct shopItem) removeShopItem;
  Function(NewProduct shopItem) addWishItem;
  Function(NewProduct shopItem) removeWishItem;
  ProductViewModel(
      {
        this.changeLikeStatus,
        this.changeAddStatus,
        this.addShopItem,
        this.removeShopItem,
        this.addWishItem,
        this.removeWishItem,
      });

  factory ProductViewModel.create(Store<AppState> store) {

    _onChangeStatusProductList(int index, bool isLiked) {
      store.dispatch(LikeStatusAction(index, isLiked));
    }

    _onChangeAddStatusProductList(int index, bool isAdded, int weight) {
      store.dispatch(AddStatusAction(index, isAdded, weight));
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
    return ProductViewModel(
        changeLikeStatus: _onChangeStatusProductList,
        changeAddStatus: _onChangeAddStatusProductList,
        addShopItem: _addShopItem,
        removeShopItem: _removeShopItem,
        addWishItem: _addWishItem,
        removeWishItem: _removeWishItem,
    );
  }
}
