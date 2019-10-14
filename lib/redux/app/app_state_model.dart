import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';

class AppState {
  UserModel user_info;
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
      this.shopItems,
      this.wishItems,
      this.newProducts});

  @override
  String toString() {
    return 'AppState{ userLogin: $user_info}';
  }
}
