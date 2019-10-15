import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem3.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class ListTimeWidgetAnimation extends StatefulWidget {
  ShoppingCartViewModel viewModel;

  ListTimeWidgetAnimation(this.viewModel);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListTimeWidgetAnimationState();
  }
}

class _ListTimeWidgetAnimationState extends State<ListTimeWidgetAnimation>
    with SingleTickerProviderStateMixin {
  /// Attributes
  AnimationController controller;
  Animation<Offset> offset;
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
    ShoppingCartViewModel viewModel=widget.viewModel;
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
  }

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }
  Widget _buildTotals() {
    double subtotal = 0;
    for (int i = 0; i < widget.viewModel.shopItems.length; i++) {
      subtotal = subtotal + double.parse(widget.viewModel.shopItems[i].price);
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
      child: NotificationListener(
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: viewModel.shopItems
              .map(
                (NewProduct shopItem) =>
                NewGroceryListItemThree(shopItem),
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