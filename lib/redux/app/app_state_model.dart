import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class AppState {
  UserModel user_info;
  int code;
  List<NewProduct> shopItems;
  List<NewProduct> wishItems;
  List<NewProduct> newProducts;

  AppState.initialState()
      : user_info = UserModel(),
        shopItems = new List<NewProduct>(),
        wishItems = new List<NewProduct>(),
        newProducts = new List<NewProduct>();

  AppState(
      {this.user_info,
      this.code,
      this.shopItems,
      this.wishItems,
      this.newProducts});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
