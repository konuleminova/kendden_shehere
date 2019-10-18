import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem3.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';

class BuildTotalWidgetAnimation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BuildTotalWidgetAnimationState();
  }
}

class _BuildTotalWidgetAnimationState extends State<BuildTotalWidgetAnimation>
    with SingleTickerProviderStateMixin {
  /// Attributes
  AnimationController controller;
  Animation<Offset> offset;
  ShoppingCartViewModel viewModel;

  /// Widgets
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
  return  new StoreConnector(
        onInitialBuild: (ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;

        },
        onDispose: (store) {
         // store.state.shopItems.clear();
        },
        converter: (Store<AppState> store) =>
            ShoppingCartViewModel.create(store),
        builder: (BuildContext context, ShoppingCartViewModel viewModel) {
          this.viewModel = viewModel;
          return Stack(
            children: <Widget>[
              Align(
                child: _shopBody(viewModel),
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
          );
        });
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  Widget _buildTotals() {
    double subtotal = 0;
    for (int i = 0; i < viewModel.shopItems.length; i++) {
      subtotal = subtotal +
          double.parse(viewModel.shopItems[i].price) *
              viewModel.shopItems[i].weight;
    }
    SharedPrefUtil()
        .setString(SharedPrefUtil().price, subtotal.toStringAsFixed(2));
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

  Widget _shopBody(ShoppingCartViewModel viewModel) => new Container(
      margin: EdgeInsets.only(bottom: 10, top: 16, left: 10, right: 12),
      padding: EdgeInsets.only(bottom: 140),
      child: NotificationListener(
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: viewModel.shopItems
              .map(
                (Product shopItem) => GroceryListItemThree(shopItem),
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
}
