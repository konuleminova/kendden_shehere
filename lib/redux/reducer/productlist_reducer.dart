import 'package:kendden_shehere/redux/data/model/newmodel/new_product_model.dart';
import 'package:kendden_shehere/redux/action/productlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<NewProduct>> productListReducer =
    combineReducers<List<NewProduct>>([
  TypedReducer<List<NewProduct>, FetchProductListAction>(
      fetchProductListAction),
]);

List<NewProduct> fetchProductListAction(
    List<NewProduct> state, FetchProductListAction action) {
  return []..addAll(action.data);
}
