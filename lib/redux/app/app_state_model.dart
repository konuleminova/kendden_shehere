import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';

class AppState {
  UserModel user_info;
  Home home;
  List<Product> products;
  int code;
  List<Product> shopItems;
  List<NewProduct> wishItems;
  String lang;
  List<NewProduct> newProducts;
  String filterOrder;

  AppState.initialState()
      : user_info = UserModel(),
        home = Home(),
        shopItems = new List<Product>(),
        products = new List<Product>(),
        wishItems = new List<NewProduct>(),
        newProducts = new List<NewProduct>(),
        lang = "tr",filterOrder="0";

  AppState(
      {this.user_info,
      this.code,
      this.home,
      this.shopItems,
      this.products,
      this.wishItems,
      this.lang,
      this.newProducts,this.filterOrder});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
