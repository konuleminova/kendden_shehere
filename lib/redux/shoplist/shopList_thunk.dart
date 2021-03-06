import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/redux/shoplist/shop_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> shopListThunkAction() {
  return (Store<AppState> store) async {
    var response = await Networks().basket();

    if (response != null) {
      if (response != '0') {
        OrderHistoryListModel responsex=response;
        store.state.shopItems = responsex.orderList[0].list.productsInCategory;
        store.dispatch(FetchShopListAction(
            data: responsex.orderList[0].list.productsInCategory));
        store.dispatch(ShowBasketAction(store));
      }
    }
  };
}
