import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/connectivity/con_enum.dart';
import 'package:kendden_shehere/connectivity/con_service.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/app_translations_delegate.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/redux/navigation/navigation_middleware.dart';
import 'package:kendden_shehere/redux/navigation/navigation_observer.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/menu/about_us.dart';
import 'package:kendden_shehere/ui/page/menu/complaints.dart';
import 'package:kendden_shehere/ui/page/menu/contacts.dart';
import 'package:kendden_shehere/ui/page/menu/delivery.dart';
import 'package:kendden_shehere/ui/page/menu/fag.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_wish_list.dart';
import 'package:kendden_shehere/ui/page/map/searchplace.dart';
import 'package:kendden_shehere/ui/page/grocery/order_history.dart';
import 'package:kendden_shehere/ui/page/grocery/order_shop_list.dart';
import 'package:kendden_shehere/ui/page/payment/checkout.dart';
import 'package:kendden_shehere/ui/page/payment/confirm_order.dart';
import 'package:kendden_shehere/ui/page/menu/profile.dart';
import 'package:kendden_shehere/ui/page/menu/settings.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/page/index.dart';
import 'package:kendden_shehere/ui/page/login.dart';
import 'package:kendden_shehere/ui/page/pin_code_view.dart';
import 'package:kendden_shehere/ui/page/register.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_reducer.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
//final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
//final GlobalKey<ScaffoldState> scaffoldRegisterKey =
//    new GlobalKey<ScaffoldState>();

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
    SharedPrefUtil().getString(SharedPrefUtil().lang).then((onvalue) {
      if (onvalue != "") {
        application.onLocaleChanged(Locale(onvalue, ""));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
        child: StoreProvider<AppState>(
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
              "/home": (BuildContext context) => HomePage(
                    fromCheckout: false,
                  ),
              //  "/shopping_cart": (BuildContext context) => GroceryShopCartPage(),
              "/wish_list": (BuildContext context) => GroceryWishListPage(),
              "/confirm_order": (context) => ConfirmOrderPage(),
              "/checkout": (BuildContext context) => CheckoutsPage(),
              "/order_history": (BuildContext context) => OrderHistoryPage(),
              "/order_shop_list": (BuildContext context) => OrderShopListPage(),
              "/profile": (BuildContext context) => ProfilePage(),
              "/settings": (BuildContext context) => SettingsPage(),
              "/search_place": (BuildContext context) => CustomSearchScaffold(),
              "/about_us": (BuildContext context) => AboutUsPage(),
              "/delivery_terms": (BuildContext context) => DeliveryPage(),
              "/fag": (BuildContext context) => FagPage(),
              "/contacts": (BuildContext context) => ContactsPage(),
              "/categories": (BuildContext context) => GroceryCategoriesPage(),
              '/complaints':(BuildContext context) => ComplaintsPage(),
              '/pin_code':(BuildContext context) => PinCodePage()

              // "/product_list": (BuildContext context) => ProductListPage()
            },
          ),
        ));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
      _locale = locale;
    });
  }
}
