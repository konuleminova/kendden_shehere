import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> searchListThunkAction(String lang, String query,String page,String state) {
  return (Store<AppState> store) async {
    ProductsInCategory response = await Networks().search(lang, query,page);
    if (response != null) {
      if (state == "init") {
        store.dispatch(
            FetchProductListAction(data: response.productsInCategory));
        Future.delayed(const Duration(milliseconds: 1000), () {
          store.dispatch(ShowBasketAction(store));
          store.dispatch(ShowWishAction(store));
        });
      } else {
        store.dispatch(
            LoadMoreProductListAction(data: response.productsInCategory));
        Future.delayed(const Duration(milliseconds: 1000), () {
          store.dispatch(ShowBasketAction(store));
          store.dispatch(ShowWishAction(store));
        });
      }
    }
  };
}
