import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';

Reducer<List<NewProduct>> homeReducer = combineReducers<List<NewProduct>>([
  TypedReducer<List<NewProduct>, FetchProductsAction>(fetchNewProductsReducer),
]);

List<NewProduct> fetchNewProductsReducer(
    List<NewProduct> state, FetchProductsAction action) {
  return []..addAll(action.data);
}

Reducer<ProductsInCategory> collectionReducer =
    combineReducers<ProductsInCategory>([
  TypedReducer<ProductsInCategory, CollectionAction>(fetchCollectionReducer),
]);

ProductsInCategory fetchCollectionReducer(
    ProductsInCategory state, CollectionAction action) {
  return action.collection;
}
