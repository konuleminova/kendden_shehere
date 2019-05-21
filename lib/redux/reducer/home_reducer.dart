import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/home_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/redux/action/home_action.dart';

Reducer<List<Product>> homeReducer = combineReducers<List<Product>>(
    [
      TypedReducer<List<Product>, FetchProductsAction>(fetchProductsReducer),

    ]);



List<Product> fetchProductsReducer(List<Product> state,
    FetchProductsAction action) {
  return []..addAll(action.data);
}
