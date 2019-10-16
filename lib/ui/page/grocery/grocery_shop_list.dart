import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/widgets/animation_shop_cart.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
class GroceryShopCartPage extends StatelessWidget {
  bool fromCheckout;
  ShoppingCartViewModel viewModel;
  BuildContext context;
  GroceryShopCartPage({this.fromCheckout}); //  @override
  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          print("INIT BUILD");
          viewModel.onFetchShopList();
        },
        onDispose: (store){
          store.state.shopItems.clear();
        },
        converter: (Store<AppState> store) =>
            ShoppingCartViewModel.create(store),
        builder: (BuildContext context, ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.lightGreen,
                title: new Text("Shopping List"),
              ),
              body: fromCheckout
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
                  : BuildTotalWidgetAnimation());
        });
  }
}

