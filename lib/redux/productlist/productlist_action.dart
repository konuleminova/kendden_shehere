import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:redux/redux.dart';

class FetchProductListAction {
  List<Product> data;

  FetchProductListAction({this.data});
}

class LoadMoreProductListAction {
  List<Product> data;

  LoadMoreProductListAction({this.data});
}

class ShowBasketAction {
  Store<AppState> store;

  ShowBasketAction(this.store);
}

class ShowWishAction {
  Store<AppState> store;

  ShowWishAction(this.store);
}
