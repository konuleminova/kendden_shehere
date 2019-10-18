import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:kendden_shehere/redux/search/search_thunk.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id, String lang, String limit, String page, String order)
      onFetchProductList;
  List<Product> productList;
  Function(String order) changeOrder;
  String order;
  Function(String id, String lang, String limit, String page, String order)
      onLoadMoreProductList;
  Function(String id, String lang, String limit, String page, String order)
      onChangeOrderProductList;
  Function(String lang, String query) onSearchProductList;
  ProductListViewModel(
      {this.onFetchProductList,
      this.productList,
      this.changeOrder,
      this.order,
      this.onLoadMoreProductList,
      this.onChangeOrderProductList,
      this.onSearchProductList
      });

  factory ProductListViewModel.create(Store<AppState> store) {
    _onFetchProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "init"));
    }

    _onLoadMoreProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "loadMore"));
    }

    _onChangeOrderProductList(
        String id, String lang, String limit, String page, String order) {
      store.dispatch(
          productListThunkAction(id, lang, limit, page, order, "change"));
    }

    _onSearchProductList(String lang, String query) {
      store.dispatch(searchListThunkAction(lang, query));
    }

    return ProductListViewModel(
        productList: store.state.newProducts,
        onFetchProductList: _onFetchProductList,
        onLoadMoreProductList: _onLoadMoreProductList,
        onChangeOrderProductList: _onChangeOrderProductList,
        onSearchProductList: _onSearchProductList
        );
  }
}
