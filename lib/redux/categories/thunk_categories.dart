import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/categories/categories_action.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> categoriesThunkAction(String id) {
  return (Store<AppState> store) async {
    List<Category> list=new List();
    ListCategories response = await Networks.listCategories();
    if (response != null) {
      for (int i = 0; i < response.categories.length; i++) {
        if (response.categories[i].parent == id) {
          list.add(response.categories[i]);
        }
      }
      store.dispatch(FetchCategoriesAction(categories: list));
      print(response.toString());
    }
    ;
  };
}
