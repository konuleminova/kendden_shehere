import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';

class WishListViewModel {
  Function(Product wishItem) removeWishItem;
  List<Product> wishItems;
  Function() onFetchWishList;

  WishListViewModel(
      {this.removeWishItem,
      this.wishItems,
      this.onFetchWishList});

  factory WishListViewModel.create(Store<AppState> store) {
    _onFetchWishList() {
      store.dispatch(wishListThunkAction());
    }

    _removeShopItem(Product product) {
      store.dispatch(RemoveWishItemAction(removeWishItem: product));
    }

    return WishListViewModel(
        removeWishItem: _removeShopItem,
        wishItems: store.state.wishItems,
        onFetchWishList: _onFetchWishList);
  }
}
