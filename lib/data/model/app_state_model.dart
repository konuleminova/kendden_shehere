import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/home_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';
import 'package:kendden_shehere/data/model/login_model.dart';

class AppState {
  UserLogin user_info;
  Home home;
  List<Product> products;
  int code;
  List<Product> shopItems;
  List<Product> wishItems;

  AppState.initialState()
      : user_info = UserLogin(),
        home = Home(),
        shopItems = new List<Product>(),
        products = new List<Product>(),
        wishItems = new List<Product>();

  AppState(
      {this.user_info,
      this.code,
      this.home,
      this.shopItems,
      this.products,
      this.wishItems});

  static AppState fromJson(dynamic json) {
    if (json != null) {
      return AppState(
          user_info: UserLogin.fromJson(json['user_info']), code: json['code']);
    }
  }

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
