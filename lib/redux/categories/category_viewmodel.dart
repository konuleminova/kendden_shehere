import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/categories/categories_reducer.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/thunk_categories.dart';
import 'package:kendden_shehere/redux/filter/filter_action.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/thunk_productlist.dart';
import 'package:redux/redux.dart';

class CategoryViewModel {
  Function(String id) onFetchCategories;
  List<Category> categories;

  CategoryViewModel({
    this.onFetchCategories,
    this.categories,
  });

  factory CategoryViewModel.create(Store<AppState> store) {
    _onFetchProductList(String id) {
      store.dispatch(categoriesThunkAction(id));
    }

    return CategoryViewModel(
        onFetchCategories: _onFetchProductList,
        categories: store.state.categories);
  }
}
