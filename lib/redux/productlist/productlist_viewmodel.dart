import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/filter/filter_action.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id, String limit, String page, String order)
      onFetchProductList;
  List<NewProduct> productList;
  Function(String order) changeOrder;
  String order;

  ProductListViewModel(
      {this.onFetchProductList,
      this.productList,
      this.changeOrder,
      this.order});

  factory ProductListViewModel.create(Store<AppState> store) {
    _onFetchProductList(String id, String limit, String page, String order) {
      store.dispatch(productListThunkAction(id, limit, page, order));
    }

    _changeOrder(String order) {
      store.dispatch(ChangeFilterOrderAction(order: order));
    }

    return ProductListViewModel(
        onFetchProductList: _onFetchProductList,
        productList: store.state.newProducts,
        changeOrder: _changeOrder,
        order: store.state.filterOrder);
  }
}
