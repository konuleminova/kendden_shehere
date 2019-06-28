import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';

class AppState {
  UserModel user_info;
  Home home;
  List<Product> products;
  int code;
  List<Product> shopItems;
  List<Product> wishItems;
  String lang;
  List<NewProduct> newProducts;

  AppState.initialState()
      : user_info = UserModel(),
        home = Home(),
        shopItems = new List<Product>(),
        products = new List<Product>(),
        wishItems = new List<Product>(),
        newProducts = new List<NewProduct>(),
        lang = "tr";

  AppState(
      {this.user_info,
      this.code,
      this.home,
      this.shopItems,
      this.products,
      this.wishItems,
      this.lang,
      this.newProducts});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
