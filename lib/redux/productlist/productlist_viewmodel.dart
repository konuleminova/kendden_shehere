import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id,String lang, String limit, String page, String order)
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
    _onFetchProductList(String id,String lang, String limit, String page, String order) {
      store.dispatch(productListThunkAction(id,lang, limit, page, order));
    }

    return ProductListViewModel(
        productList: store.state.newProducts,
        onFetchProductList: _onFetchProductList,
        order: store.state.filterOrder);
  }
}
