import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/redux/middleware/thunk_productlist.dart';
import 'package:redux/redux.dart';

class ProductListViewModel {
  Function(String id, String limit, String page) onFetchProductList;

  ProductListViewModel({this.onFetchProductList});

  factory ProductListViewModel.create(Store<AppState> store) {
    _onFetchProductList(String id, String limit, String page) {
      store.dispatch(productListThunkAction(id, limit, page));
    }

    return ProductListViewModel(onFetchProductList: _onFetchProductList);
  }
}
