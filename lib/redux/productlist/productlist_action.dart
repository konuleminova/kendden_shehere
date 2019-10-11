import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:redux/redux.dart';

class FetchProductListAction {
  List<NewProduct> data;

  FetchProductListAction({this.data});
}

class LoadMoreProductListAction {
  List<NewProduct> data;

  LoadMoreProductListAction({this.data});
}

class LikeStatusAction {
  int index;
  bool isLiked;

  LikeStatusAction(this.index, this.isLiked);
}

class AddStatusAction {
  int index;
  bool isAdded;
  int weight;

  AddStatusAction(this.index, this.isAdded, this.weight);
}

class ShowBasketAction {
  Store<AppState> store;

  ShowBasketAction(this.store);
}

class ShowWishAction {
  Store<AppState> store;

  ShowWishAction(this.store);
}
