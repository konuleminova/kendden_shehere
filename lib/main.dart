import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/app_translations_delegate.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/navigation/navigation_middleware.dart';
import 'package:kendden_shehere/navigation/navigation_observer.dart';
import 'package:kendden_shehere/ui/page/grocery/new_grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/menu/about_us.dart';
import 'package:kendden_shehere/ui/page/menu/delivery.dart';
import 'package:kendden_shehere/ui/page/menu/fag.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_wish_list.dart';
import 'package:kendden_shehere/ui/page/map/searchplace.dart';
import 'package:kendden_shehere/ui/page/payment/new_checkout.dart';
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
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_reducer.dart';
import 'package:kendden_shehere/ui/page/test/old_shopping_cart.dart';
import 'package:kendden_shehere/ui/widgets/dropdown.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  final Store<AppState> store = Store<AppState>(appStateReducer,
      initialState: AppState.initialState(),
      middleware: [thunkMiddleware]..addAll(createNavigationMiddleware()));

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  Locale _locale;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: new Locale("en"));
    application.onLocaleChanged = onLocaleChange;
    _locale = new Locale("en", "");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreProvider<AppState>(
      store: widget.store,
      child: new MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        locale: _locale,
        onGenerateTitle: (BuildContext context) =>
            AppTranslations.of(context).text("title_select_language"),
        localizationsDelegates: [
          _newLocaleDelegate,
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en", ""),
          const Locale("ru", ""),
          const Locale("tr", ""),
        ],
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
          "/wish_list": (BuildContext context) => GroceryWishListPage(),
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
          "/fag": (BuildContext context) => FagPage(),
          "/categories": (BuildContext context) => GroceryCategoriesPage()

          // "/product_list": (BuildContext context) => ProductListPage()
        },
      ),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      _locale = locale;
    });
  }
}
