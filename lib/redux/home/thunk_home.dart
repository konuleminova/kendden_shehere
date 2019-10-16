import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> shoAllCollectionThunkAction() {
  return (Store<AppState> store) async {
    var response = await Networks().showAllCollection();
    print(response);
    if (response != null) {
      store.dispatch(ShowAllCollectionAction(homeList: response));
      Future.delayed(const Duration(milliseconds: 1500), () {
        store.dispatch(ShowHomeBasketAction(store));
        store.dispatch(ShowHomeWishAction(store));
      });
    }
  };
}

ThunkAction<AppState> bannerImagesThunkAction() {
  return (Store<AppState> store) async {
    var response = await Networks().bannerImages();
    print(response);
    if (response != null) {
      store.dispatch(BannerImagesAction(photos: response));
    }
  };
}
