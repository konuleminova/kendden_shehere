import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/thunk_home.dart';

class HomeViewModel {
  Function(String id) onFetchProductList;
  List<NewProduct> productList;
  List<NewProduct>  collections;
  Function() onGetCollections;

  HomeViewModel(
      {this.onFetchProductList,
      this.productList,
      this.onGetCollections,
      this.collections});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchProductList(id) {
      store.dispatch(getProductListThunkAction(id));
    }

    _onCollection() {
      store.dispatch(getCollectionCountThunk());
    }

    return HomeViewModel(
        onFetchProductList: _onFetchProductList,
        onGetCollections: _onCollection(),
    );
  }
}
