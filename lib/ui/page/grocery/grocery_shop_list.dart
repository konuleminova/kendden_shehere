import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem3.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';

class GroceryShopCartPage extends StatefulWidget {
  bool fromCheckout = false;

  GroceryShopCartPage({this.fromCheckout});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryCartState();
  }
}

class GroceryCartState extends State<GroceryShopCartPage>
    with SingleTickerProviderStateMixin {
  ShoppingCartViewModel viewModel;
  var increment = 1;
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  void dispose() {
    widget.fromCheckout = false;
    super.dispose();
    viewModel.shopItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          viewModel.onFetchShopList();
        },
        converter: (Store<AppState> store) =>
            ShoppingCartViewModel.create(store),
        builder: (BuildContext context, ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          return WillPopScope(
              child: new Scaffold(
                  appBar: new AppBar(
                    backgroundColor: Colors.lightGreen,
                    title: new Text("Shopping List"),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
//                        Navigator.pop(context);
//                        Navigator.popUntil(context,
//                            ModalRoute.withName(Navigator.defaultRouteName));
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
                      },
                    ),
                  ),
                  body: widget.fromCheckout && viewModel.shopItems.length < 0
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
                      : Stack(
                          children: <Widget>[
                            Align(
                              child: _shopBody(),
                              alignment: Alignment.topCenter,
                            ),
                            viewModel.shopItems.length > 0
                                ? Align(
                                    child: SlideTransition(
                                      child: _buildTotals(),
                                      position: offset,
                                    ),
                                    alignment: Alignment.bottomCenter,
                                  )
                                : Container()
                          ],
                        )),
              onWillPop: () {
//                Navigator.popUntil(
//                    context, ModalRoute.withName(Navigator.defaultRouteName));
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
              });
        });
  }

  Widget _shopBody() => new Container(
      margin: EdgeInsets.only(bottom: 10, top: 16, left: 10, right: 12),
      child: NotificationListener(
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: viewModel.shopItems
              .map(
                (NewProduct shopItem) =>
                    NewGroceryListItemThree(shopItem, viewModel),
              )
              .toList(),
        ),
        onNotification: (t) {
          if (t is ScrollStartNotification) {
            controller.forward();
          } else if (t is ScrollEndNotification) {
            controller.reverse();
          }
        },
      ));

  Widget _buildTotals() {
    double subtotal = 0;
    for (int i = 0; i < viewModel.shopItems.length; i++) {
      subtotal = subtotal + double.parse(viewModel.shopItems[i].price);
    }
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    sharedPrefUtil.setString(SharedPrefUtil.price, subtotal.toStringAsFixed(2));
    return (controller.status == AnimationStatus.dismissed)
        ? ClipOval(
            clipper: OvalTopBorderClipper(),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 25.0,
                        color: Colors.black,
                        spreadRadius: 100.0),
                  ],
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[100])),
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Subtotal"),
                      Text(subtotal.toStringAsFixed(2) + " AZN"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Total"),
                      Text(subtotal.toStringAsFixed(2) + " AZN"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pushNamed(context, "/checkout");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Checkout", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
