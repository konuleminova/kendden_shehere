import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/data/model/order_history_model.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/rating_star_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem3.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem4.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class OrderShopListPage extends StatelessWidget {
  List<Product> products = new List();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    //context = this.context;
    products.add(
      new Product(
          title: "Order Name",
          subtitle: "27.02.2019",
          price: "1 AZN",
          image:
              "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190507"),
    );
    products.add(
      new Product(
          title: "Order Name",
          subtitle: "28.05.2019",
          price: "1 AZN",
          image:
              "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190507"),
    );
    products.add(
      new Product(
          title: "Order Name",
          subtitle: "1.02.2019",
          price: "1 AZN",
          image:
              "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190507"),
    );
    products.add(
      new Product(
          title: "Order Name",
          subtitle: "3.04.2019",
          price: "1 AZN",
          image:
              "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190507"),
    );
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text("Order History"),
        actions: <Widget>[
          new Container(
            child: new Icon(Icons.more_vert),
            margin: EdgeInsets.only(right: 8),
          ),
        ],
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
            GroceryListItemFour(new Product(
                title: product.title,
                subtitle: product.subtitle,
                amount: 1,
                price: product.price,
                image: product.image)),
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
