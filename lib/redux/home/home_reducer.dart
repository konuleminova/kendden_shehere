import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';

Reducer<HomeList> homeReducer = combineReducers<HomeList>([
  TypedReducer<HomeList, ShowAllCollectionAction>(showAllCollectionReducer),
  TypedReducer<HomeList, ShowHomeBasketAction>(
      showBasketHomeProductListReducer),
  TypedReducer<HomeList, ShowHomeWishAction>(showWishHomeProductListReducer),
]);

HomeList showAllCollectionReducer(
    HomeListstate, ShowAllCollectionAction action) {
  return action.homeList;
}

HomeList showBasketHomeProductListReducer(
    HomeList state, ShowHomeBasketAction action) {
  action.store.state.homeList.homelist.forEach((item) {
    item.list.forEach((l) {
      action.store.state.shopItems.forEach((f) {
        if (l.id == f.id) {
          l.isAdded = true;
          l.weight = f.weight;
        }
      });
    });
  });
  return state;
}

bool containsF(Product element, wishItems) {
  for (Product e in wishItems) {
    if (e.id == element.id) return true;
  }
  return false;
}

HomeList showWishHomeProductListReducer(
    HomeList state, ShowHomeWishAction action) {
  print("SHOOWW HOMEE::" + action.store.state.wishItems.toString());
  print("HOMEE LIST WISH:" + action.store.state.homeList.homelist.toString());
  //action.store.state.homeList.homelist[0].list
  // action.store.state.homeList.homelist[0].list[0].isLiked = false;
  action.store.state.homeList.homelist.forEach((item) {
    item.list.forEach((l) {
      if (containsF(l, action.store.state.wishItems)) {
        l.isLiked = true;
        print("TRUEE");
      } else {
        l.isLiked = false;
        print("FALSE");
      }
    });
  });
  return state;
}
