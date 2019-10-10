import 'package:kendden_shehere/redux/productlist/new_product_model.dart';

class FetchProductListAction {
  List<NewProduct> data;

  FetchProductListAction({this.data});
}

class LoadMoreProductListAction {
  List<NewProduct> data;

  LoadMoreProductListAction({this.data});
}

class StatusAction {
  int index;
  bool isLiked;

  StatusAction(this.index, this.isLiked);
}

class AddStatusAction {
  int index;
  bool isAdded;
  int weight;

  AddStatusAction(this.index, this.isAdded, this.weight);
}
