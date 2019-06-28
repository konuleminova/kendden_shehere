import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/data/model/order_history_model.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class GroceryListItemFour extends StatefulWidget {
  Product orderProduct;

  GroceryListItemFour(this.orderProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroceryListItemFourState();
  }
}

class GroceryListItemFourState extends State<GroceryListItemFour> {
  Product orderProduct;
  String title, subtitle, price, image;
  int amount;

  @override
  Widget build(BuildContext context) {
    orderProduct = widget.orderProduct;
    title = orderProduct.title;
    subtitle = orderProduct.subtitle;
    amount = widget.orderProduct.amount;
    price = widget.orderProduct.price;
    image = widget.orderProduct.image;

    // TODO: implement build
    return GestureDetector(
      child: Card(
          margin: EdgeInsets.all(12),
          child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 3.0,
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border:
                        new Border.all(width: 0.5, color: Colors.lightGreen)),
                child: ListTile(
                    leading: Container(
                        height: 80.0,
                        width: 100,
                        child: Image.network(
                          image,
                          //height: 80.0,
                        )),
                    title: Container(
                      height: 110.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GroceryTitle(text: title),
                          new GrocerySubtitle(text: subtitle),
                          new GrocerySubtitle(text: amount.toString() + "kq"),
                        ],
                      ),
                    ),
                    trailing: new Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new GroceryTitle(text: price),
                          // new RatingStarWidget(5, 0, 20),
                          _statusWidget(),
                          //new GrocerySubtitle(text: amount.toString()+" kq"),
                        ],
                      ),
                    )),
              ))),
      onTap: () {
        Navigator.pushNamed(context, "/product_detail");
      },
    );
  }

  _statusWidget() {
    return Text(
      "4kq",
      style: TextStyle(
          color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
