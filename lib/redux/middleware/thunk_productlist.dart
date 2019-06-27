import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/newmodel/new_product_model.dart';
import 'package:kendden_shehere/data/model/newmodel/products_in_category_model.dart';
import 'package:kendden_shehere/redux/action/productlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> productListThunkAction(
    String id, String limit, String page) {
  return (Store<AppState> store) async {
    ProductsInCategory response =
        await Networks.productsInCategory(id, "0", "0", limit, page);
    if (response != null) {
      store.state.newProducts = response.productsInCategory;
      store.dispatch(FetchProductListAction(data: response.productsInCategory));
    }
  };
}
