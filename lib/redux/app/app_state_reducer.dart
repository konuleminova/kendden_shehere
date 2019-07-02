import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/filter/filter_reducer.dart';
import 'package:kendden_shehere/redux/home/home_reducer.dart';
import 'package:kendden_shehere/redux/lang/lang_reducer.dart';
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
      products: homeReducer(state.products, action),
      lang: langReducer(state.lang, action),
      newProducts: productListReducer(state.newProducts, action),
      filterOrder: filterReducer(state.filterOrder,action));
}
