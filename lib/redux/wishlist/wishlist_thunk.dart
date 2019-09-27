import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> wishListThunkAction() {
  return (Store<AppState> store) async {
    List_Wish_Model response = await Networks.wishList();
    if (response != null) {
      store.state.wishItems = response.productsInCategory[0].list;
      store.dispatch(
          FetchWishListAction(data: response.productsInCategory[0].list));
    }
  };
}
