import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> productListThunkAction(
    String id, String lang, String limit, String page, String order) {
  return (Store<AppState> store) async {
    ProductsInCategory response =
        await Networks().productsInCategory(id, order, lang, limit, page);
    if (response != null) {
      store.dispatch(FetchProductListAction(data: response.productsInCategory));
    } else {
      store.dispatch(FetchProductListAction(data: []));
    }
  };
}
