import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';

class WishListViewModel {
  Function(NewProduct shopItem) removeWishItem;
  Function(NewProduct product) addWishItem;
  List<NewProduct> wishItems;
  Function() onFetchWishList;

  WishListViewModel(
      {this.removeWishItem,
      this.wishItems,
      this.addWishItem,
      this.onFetchWishList});

  factory WishListViewModel.create(Store<AppState> store) {
    _onFetchWishList() {
      store.dispatch(wishListThunkAction());
    }

    _removeShopItem(NewProduct product) {
      store.dispatch(RemoveWishItemAction(removeWishItem: product));
    }

    _addWishItem(NewProduct product) {
      store.dispatch(AddWishItemAction(product: product));
    }

    return WishListViewModel(
        removeWishItem: _removeShopItem,
        wishItems: store.state.wishItems,
        addWishItem: _addWishItem,
        onFetchWishList: _onFetchWishList);
  }
}
