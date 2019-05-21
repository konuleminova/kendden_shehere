import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/redux/action/wishlist_action.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';
import 'package:kendden_shehere/redux/action/shop_action.dart';

class WishListViewModel {
  Function(Product shopItem) removeWishItem;
  Function(Product product) addWishItem;
  List<Product> wishItems;

  WishListViewModel({this.removeWishItem, this.wishItems,this.addWishItem});

  factory WishListViewModel.create(Store<AppState> store) {
    _removeShopItem(Product product) {
      store.dispatch(RemoveWishItemAction(removeWishItem: product));
    }
    _addWishItem(Product product) {
      store.dispatch(AddWishItemAction(product: product));
    }

    return WishListViewModel(
        removeWishItem: _removeShopItem, wishItems: store.state.shopItems,addWishItem:_addWishItem);
  }
}
