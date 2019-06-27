import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/redux/reducer/home_reducer.dart';
import 'package:kendden_shehere/redux/reducer/lang_reducer.dart';
import 'package:kendden_shehere/redux/reducer/login_reducer.dart';
import 'package:kendden_shehere/redux/reducer/productlist_reducer.dart';
import 'package:kendden_shehere/redux/reducer/shop_reducer.dart';
import 'package:kendden_shehere/redux/reducer/wishlist_reduces.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
      shopItems: shopReducer(
        state.shopItems,
        action,
      ),
      wishItems: wishListReducer(state.wishItems, action),
      user_info: loginReducer(state.user_info, action),
      products: homeReducer(state.products, action),
      lang: langReducer(state.lang, action),newProducts:productListReducer(state.newProducts, action));
}
