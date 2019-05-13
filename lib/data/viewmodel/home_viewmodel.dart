import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/redux/action/home_action.dart';
import 'package:kendden_shehere/redux/middleware/thunk_home.dart';

class HomeViewModel {
  Function(int limit, int page) onFetchProductList;
  Function(Product product) onAddedProduct;

  HomeViewModel({this.onFetchProductList, this.onAddedProduct});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchProductList(int limit, int page) {
      store.dispatch(getProductListThunkAction(limit, page));
    }

    _onAddedProduct(Product product) {
      store.dispatch(AddProductAction(product: product));
    }

    return HomeViewModel(
        onFetchProductList: _onFetchProductList,
        onAddedProduct: _onAddedProduct);
  }
}
