import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> wishListThunkAction() {
  return (Store<AppState> store) async {
    List_Wish_Model response = await Networks().wishList();
    if (response != null) {
      store.dispatch(
          FetchWishListAction(data: response.productsInCategory[0].list));
    }
  };
}
