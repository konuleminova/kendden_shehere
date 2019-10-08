import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class FetchProductsAction {
  int count;
  List<NewProduct> data;
  FetchProductsAction({this.data,this.count});
}
class  CollectionAction{
  ProductsInCategory collection;

  CollectionAction({this.collection});


}


