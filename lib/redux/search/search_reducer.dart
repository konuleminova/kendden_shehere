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
  List<NewProduct> tempList=new List();
  //tempList.addAll(action.data);
  for(int i=0;i<action.data.length;i++){
    if(action.data[i].hasphoto=="1"){
      tempList.add(action.data[i]);
    }
  }
  return tempList;
}
