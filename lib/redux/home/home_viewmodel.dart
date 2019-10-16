import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/home/thunk_home.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shopList_thunk.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';

class HomeViewModel {
  Function() onFetchAllCollection;
  HomeList homeList;
  List<NewProduct> shopItems;
  Function() onFetchShopList;
  List<NewProduct> wishItems;
  Function() onFetchWishList;
  Function() fetchBannerImages;
  List<String> photos;
  Function() onRefresh;

  HomeViewModel(
      {this.onFetchAllCollection,
      this.shopItems,
      this.onFetchShopList,
      this.homeList,
      this.wishItems,
      this.onFetchWishList,
      this.fetchBannerImages,
      this.photos,
      this.onRefresh});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchAllCollection() {
      store.dispatch(shoAllCollectionThunkAction());
    }

    _onFetchShopList() {
      store.dispatch(shopListThunkAction());
    }

    _onFetchWishList() {
      store.dispatch(wishListThunkAction());
    }

    _onFetchBannerImages() {
      store.dispatch(bannerImagesThunkAction());
    }

    _onRefresh() {
      store.dispatch(ShowHomeBasketAction(store));
      store.dispatch(ShowHomeWishAction(store));
    }

    return HomeViewModel(
        onFetchAllCollection: _onFetchAllCollection,
        homeList: store.state.homeList,
        shopItems: store.state.shopItems,
        onFetchShopList: _onFetchShopList,
        wishItems: store.state.wishItems,
        onFetchWishList: _onFetchWishList,
        fetchBannerImages: _onFetchBannerImages,
        photos: store.state.photos,
        onRefresh: _onRefresh);
  }
}
