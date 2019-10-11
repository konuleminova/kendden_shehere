import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_reducer.dart';
import 'package:kendden_shehere/redux/login/login_reducer.dart';
import 'package:kendden_shehere/redux/productlist/productlist_reducer.dart';
import 'package:kendden_shehere/redux/shoplist/shop_reducer.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_reduces.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
      shopItems: shopReducer(
        state.shopItems,
        action,
      ),
      wishItems: wishListReducer(state.wishItems, action),
      user_info: loginReducer(state.user_info, action),
      newProducts: productListReducer(state.newProducts, action),
      homeProducts: homeReducer(state.homeProducts, action),
      homeCollection: collectionReducer(state.homeCollection, action));
}
