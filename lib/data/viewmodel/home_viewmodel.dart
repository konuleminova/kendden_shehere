import 'package:kendden_shehere/data/model/shop_item_model.dart';
import 'package:kendden_shehere/redux/action/shop_action.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/redux/action/home_action.dart';
import 'package:kendden_shehere/redux/middleware/thunk_home.dart';

class HomeViewModel {
  Function(int limit, int page) onFetchProductList;
  Function(ShopItem product) addShopItem;
  Function(ShopItem shopItem) removeShopItem;

  HomeViewModel({this.onFetchProductList, this.addShopItem,this.removeShopItem});

  factory HomeViewModel.create(Store<AppState> store) {
    _onFetchProductList(int limit, int page) {
      store.dispatch(getProductListThunkAction(limit, page));
    }

    _addShopItem(ShopItem product) {
      store.dispatch(AddProductAction(product: product));
    }
    _removeShopItem(ShopItem product) {
      store.dispatch(RemoveShopItemAction(removeShopItem: product));
    }

    return HomeViewModel(
        onFetchProductList: _onFetchProductList,
        addShopItem: _addShopItem,removeShopItem: _removeShopItem);
  }
}
