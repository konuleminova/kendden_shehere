import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/common/model/order_history_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/rating_star_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem4.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem5.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class OrderShopListPage extends StatelessWidget {
  List<NewProduct> products;

  OrderShopListPage({this.products});

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    //context = this.context
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text("Order History"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _shopBody()),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
              child: _buildRatingStar(),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (buildContext) {
                      return RatingStarDialog();
                    });
              })
        ],
      ),
    );
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: products
              .map((NewProduct product) => _builOrderListItem(product))
              .toList(),
        ),
      );

  Widget _builOrderListItem(NewProduct product) => GestureDetector(
        child: new Stack(
          children: <Widget>[
            NewGroceryListItemFive(product),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, "/order_shop_list");
        },
      );

  _buildRatingStar() => Container(
      height: 100,
      padding: EdgeInsets.only(bottom: 16),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Text(
            "Write a Review",
            style: TextStyle(color: Colors.green, fontSize: 22),
          ),
          new RatingStarWidget(5, 0, 35),
        ],
      ));
}
