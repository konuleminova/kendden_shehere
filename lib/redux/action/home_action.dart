import 'package:kendden_shehere/data/model/home_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';

class FetchProductsAction {
  String result;
  List<Product> data;

  FetchProductsAction({this.result, this.data});
}

class AddProductAction {
  Product product;
  AddProductAction({this.product});
}
