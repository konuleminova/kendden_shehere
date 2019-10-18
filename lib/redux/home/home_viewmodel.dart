import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/home/thunk_home.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shopList_thunk.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_thunk.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';

class HomeViewModel {
  Function() onFetchAllCollection;
  HomeList homeList;
  List<Product> shopItems;
  Function() onFetchShopList;
  List<Product> wishItems;
  Function() onFetchWishList;
  Function() fetchBannerImages;
  List<String> photos;

  HomeViewModel(
      {this.onFetchAllCollection,
      this.shopItems,
      this.onFetchShopList,
      this.homeList,
      this.wishItems,
      this.onFetchWishList,
      this.fetchBannerImages,
      this.photos,});

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
    return HomeViewModel(
        onFetchAllCollection: _onFetchAllCollection,
        homeList: store.state.homeList,
        shopItems: store.state.shopItems,
        onFetchShopList: _onFetchShopList,
        wishItems: store.state.wishItems,
        onFetchWishList: _onFetchWishList,
        photos: store.state.photos,);
  }
}
