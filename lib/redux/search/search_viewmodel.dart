import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/filter/filter_action.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:kendden_shehere/redux/search/search_thunk.dart';
import 'package:redux/redux.dart';

class SearchListViewModel {
  Function(String lang, String query) onFetchProductList;
  List<NewProduct> productList;
  Function(String order) changeOrder;
  String order;

  SearchListViewModel(
      {this.onFetchProductList,
      this.productList,
      this.changeOrder,
      this.order});

  factory SearchListViewModel.create(Store<AppState> store) {
    _onFetchProductList(String lang, String query) {
      store.dispatch(searchListThunkAction(lang, query));
    }

    _changeOrder(String order) {
      store.dispatch(ChangeFilterOrderAction(order: order));
    }

    return SearchListViewModel(
        onFetchProductList: _onFetchProductList,
        productList: store.state.newProducts,
        changeOrder: _changeOrder,
        order: store.state.filterOrder);
  }
}
