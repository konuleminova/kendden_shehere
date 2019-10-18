import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/ui/widgets/dialog/rating_star_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem5.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

import 'grocery_details_page.dart';

class OrderShopListPage extends StatelessWidget {
  List<Product> products;

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
              .map((Product product) => _builOrderListItem(product))
              .toList(),
        ),
      );

  Widget _builOrderListItem(Product product) => GestureDetector(
        child: new Stack(
          children: <Widget>[
            GroceryListItemFive(product),
          ],
        ),
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (BuildContext context) => GroceryDetailsPage(product));
          Navigator.push(context, route);
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
