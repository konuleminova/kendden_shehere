import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/ui/widgets/animation_shop_cart.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';

import 'order_history.dart';

class GroceryShopCartPage extends StatelessWidget {
  bool fromCheckout;
  ShoppingCartViewModel viewModel;
  BuildContext context;
  Store<AppState> store;

  GroceryShopCartPage({this.fromCheckout}); //  @override
  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return new StoreConnector(
        onInit: (store) {
          this.store = store;
        },
        onInitialBuild: (ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          viewModel.onFetchShopList();
        },
        onDispose: (store) {
          store.dispatch(ShowHomeWishAction(store));
          store.dispatch(ShowHomeBasketAction(store));
          //store.state.shopItems.clear();
        },
        converter: (Store<AppState> store) =>
            ShoppingCartViewModel.create(store),
        builder: (BuildContext context, ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          return DefaultTabController(
            length: 2,
            child: new Scaffold(
                backgroundColor: greyFixed,
                appBar: new AppBar(
                  backgroundColor: greenFixed,
                  actions: <Widget>[
                    GestureDetector(
                      child: Image.asset('images/ks/remove.png'),
                      onTap: () {
                        // store.state.isLoading=true;
                        viewModel.isDelete(true);
                      },
                    )
                  ],
                  title:
                      new Text(AppTranslations.of(context).text('shop_list')),
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    tabs: <Widget>[
                      Tab(
                        text: AppTranslations.of(context).text('current_order'),
                      ),
                      Tab(
                        text: AppTranslations.of(context).text('order_history'),
                      )
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    fromCheckout
                        ? Container(
                            child: FutureBuilder(
                                future: Future.delayed(
                                    Duration.zero,
                                    () => showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PaymentSuccessDialog(context);
                                        })),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Container();
                                }),
                          )
                        : BuildTotalWidgetAnimation(),
                    OrderHistoryPage()
                  ],
                )),
          );
        });
  }
}
