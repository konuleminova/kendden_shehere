import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/redux/reducer/home_reducer.dart';
import 'package:kendden_shehere/redux/reducer/login_reducer.dart';
import 'package:kendden_shehere/redux/reducer/shop_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
    return AppState(
        shopItems: shopReducer(
          state.shopItems,
          action,
        ),
        user_info: loginReducer(state.user_info, action),
        products: homeReducer(state.products,action));
  }
