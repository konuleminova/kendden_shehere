import 'package:kendden_shehere/redux/home/home_list.dart';
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
          l.weight=f.weight;
        }
      });
    });
  });
  return state;
}

HomeList showWishHomeProductListReducer(
    HomeList state, ShowHomeWishAction action) {
  action.store.state.homeList.homelist.forEach((item) {
    item.list.forEach((l) {
      action.store.state.wishItems.forEach((f) {
        if (l.id == f.id) {
          l.isLiked = true;
        }
      });
    });
  });
  return state;
}

Reducer<List<String>> photoReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, BannerImagesAction>(bannerImagesReducer),
]);

List<String> bannerImagesReducer(
    List<String> state, BannerImagesAction action) {
  return action.photos;
}
