import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';

Reducer<List<Product>> homeReducer = combineReducers<List<Product>>(
    [
      TypedReducer<List<Product>, FetchProductsAction>(fetchProductsReducer),

    ]);



List<Product> fetchProductsReducer(List<Product> state,
    FetchProductsAction action) {
  return []..addAll(action.data);
}
