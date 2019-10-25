import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';

class AppState {
  UserModel user_info;
  List<Product> shopItems;
  List<Product> wishItems;
  List<Product> newProducts;
  HomeList homeList;
  List<String> photos;
  bool isScrolling=false;
  bool isLoading=false;

  AppState.initialState()
      : user_info = UserModel(),
        shopItems = new List<Product>(),
        wishItems = new List<Product>(),
        homeList = new HomeList(),
        newProducts = new List<Product>(),
        photos=new List<String>(),isScrolling=false,isLoading=false;

  AppState(
      {this.user_info, this.shopItems, this.wishItems, this.newProducts, this.homeList, this.photos,this.isScrolling,this.isLoading});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
