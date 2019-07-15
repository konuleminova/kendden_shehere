import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:redux/redux.dart';

Reducer<List<NewProduct>> productListReducer =
    combineReducers<List<NewProduct>>([
  TypedReducer<List<NewProduct>, FetchProductListAction>(
      fetchProductListAction),
]);

List<NewProduct> fetchProductListAction(
    List<NewProduct> state, FetchProductListAction action) {
  //state.clear();
  List<NewProduct> tempList=new List();
  //tempList.addAll(action.data);
  print(action.data.toString()+"actionn data");
  for (int i = 0; i < action.data.length; i++) {
    if (action.data[i].hasphoto == "1") {
      tempList.add(action.data[i]);
    }
  }
//  state.addAll(tempList);
  return tempList;
}
