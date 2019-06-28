import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';

class FetchProductsAction {
  String result;
  List<Product> data;

  FetchProductsAction({this.result, this.data});
}


