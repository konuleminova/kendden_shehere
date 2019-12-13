import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/connectivity/con_enum.dart';
import 'package:kendden_shehere/connectivity/con_service.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/app_translations_delegate.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/redux/navigation/navigation_middleware.dart';
import 'package:kendden_shehere/redux/navigation/navigation_observer.dart';
import 'package:kendden_shehere/ui/page/create_new_pass.dart';
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
import 'package:kendden_shehere/ui/page/pass_reset.dart';
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

import 'package:flutter_crashlytics/flutter_crashlytics.dart';

void main() async {
 // runApp(MyApp());
  bool isInDebugMode = false;
  profile(() {
   // isInDebugMode = true;
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(details.exception, details.stack);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  bool optIn = true;
  if (optIn) {
    await FlutterCrashlytics().initialize();
    FlutterCrashlytics().setUserInfo('test1', 'test@test.com', 'tester');
  } else {
    // In this case Crashlytics won't send any reports.
    // Usually handling opt in/out is required by the Privacy Regulations
  }

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    debugPrint(error.toString());
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: true);
  });
}

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
  BuildContext context;
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
    //context=this.context;
    // TODO: implement build
    return StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
        child: StoreProvider<AppState>(
          store: widget.store,
          child: new MaterialApp(
            navigatorKey: navigatorKey,
            navigatorObservers: [routeObserver],
            locale: _locale,
//            onGenerateTitle: (BuildContext context) =>
//                AppTranslations.of(context).text("title_select_language"),
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
            home:CreateNewPassPage(),
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
              '/complaints': (BuildContext context) => ComplaintsPage(),
              '/pin_code': (BuildContext context) => PinCodePage()

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
