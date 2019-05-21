import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:kendden_shehere/data/viewmodel/login_viewmodel.dart';
import 'package:kendden_shehere/ui/page/menu/about_us.dart';
import 'package:kendden_shehere/ui/page/menu/delivery.dart';
import 'package:kendden_shehere/ui/page/menu/fag.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/grocery/gwishlisttab.dart';
import 'package:kendden_shehere/ui/page/map/searchplace.dart';
import 'package:kendden_shehere/ui/page/test/flutter_places_webservice.dart';
import 'package:kendden_shehere/ui/page/test/login_2.dart';
import 'package:kendden_shehere/ui/page/grocery/order_history.dart';
import 'package:kendden_shehere/ui/page/grocery/order_shop_list.dart';
import 'package:kendden_shehere/ui/page/payment/checkout.dart';
import 'package:kendden_shehere/ui/page/payment/confirm_order.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/ui/page/menu/profile.dart';
import 'package:kendden_shehere/ui/page/menu/settings.dart';
import 'package:kendden_shehere/ui/page/test/old_test_cards.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/page/index.dart';
import 'package:kendden_shehere/ui/page/login.dart';
import 'package:kendden_shehere/ui/page/test/old_product_detail.dart';
import 'package:kendden_shehere/ui/page/payment/payment_method.dart';
import 'package:kendden_shehere/ui/page/register.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/reducer/app_state_reducer.dart';
import 'package:kendden_shehere/ui/page/test/old_shopping_cart.dart';
import 'package:kendden_shehere/ui/widgets/dropdown.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(appStateReducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IndexPage(),
        routes: <String, WidgetBuilder>{
          "/index": (BuildContext context) => IndexPage(),
          "/login": (BuildContext context) => LoginPage(),
          "/register": (BuildContext context) => RegisterPage(),
          "/home": (BuildContext context) => HomePage(),
          "/shopping_cart": (BuildContext context) => GroceryShopCartPage(),
          "/product_detail": (BuildContext context) => GroceryDetailsPage(),
          "/drop_down": (BuildContext context) => DropdownMenu(),
          "/wish_list": (BuildContext context) => GroceryWishlistTabView(),
          "/confirm_order": (context) => ConfirmOrderPage(),
          "/card_storage": (context) => PaymentMethodPage(),
          "/checkout": (BuildContext context) => CheckoutsPage(),
          "/order_history": (BuildContext context) => OrderHistoryPage(),
          "/order_shop_list": (BuildContext context) => OrderShopListPage(),
          "/profile": (BuildContext context) => ProfilePage(),
          "/settings": (BuildContext context) => SettingsPage(),
          "/search_place": (BuildContext context) => CustomSearchScaffold(),
          "/about_us": (BuildContext context) => AboutUsPage(),
          "/delivery_terms": (BuildContext context) => DeliveryPage(),
          "/fag": (BuildContext context) => FagPage()

          // "/product_list": (BuildContext context) => ProductListPage()
        },
      ),
    );
  }
}
