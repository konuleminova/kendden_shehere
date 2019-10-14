import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';

class AppState {
  UserModel user_info;
  List<NewProduct> shopItems;
  List<NewProduct> wishItems;
  List<NewProduct> newProducts;
  HomeList homeList;

  AppState.initialState()
      : user_info = UserModel(),
        shopItems = new List<NewProduct>(),
        wishItems = new List<NewProduct>(),
        homeList = new HomeList(),
        newProducts = new List<NewProduct>();

  AppState({this.user_info, this.shopItems, this.wishItems, this.newProducts,this.homeList});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
