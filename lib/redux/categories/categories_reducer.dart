import 'package:kendden_shehere/redux/categories/categories_action.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:redux/redux.dart';

Reducer<List<Category>> categoriesReducer = combineReducers<List<Category>>([
  TypedReducer<List<Category>, FetchCategoriesAction>(fetchCategoriesAction),
]);

List<Category> fetchCategoriesAction(
    List<Category> state, FetchCategoriesAction action) {
  state.clear();
  return state..addAll(action.categories);
}
