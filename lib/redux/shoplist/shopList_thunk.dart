import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> shopListThunkAction() {
  return (Store<AppState> store) async {
    OrderHistoryListModel response = await Networks.basket();
    if (response != null) {
      print(response.toString());
      print("SHOPP");
      print(response.orderList[0].list.productsInCategory);
      store.state.shopItems = response.orderList[0].list.productsInCategory;
      store.dispatch(FetchShopListAction(
          data: response.orderList[0].list.productsInCategory));
    }
  };
}
