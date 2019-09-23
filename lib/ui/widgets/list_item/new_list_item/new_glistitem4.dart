import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/common/model/order_history_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistrory_model.dart';
import 'package:kendden_shehere/ui/page/grocery/order_shop_list.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class NewGroceryListItemFour extends StatefulWidget {
  OrderHistoryModel orderItem;

  NewGroceryListItemFour(this.orderItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewGroceryListItemFourState();
  }
}

class NewGroceryListItemFourState extends State<NewGroceryListItemFour> {
  OrderHistoryModel orderItem;
  bool status = true;
  int amount;

  @override
  Widget build(BuildContext context) {
    orderItem = widget.orderItem;

    // TODO: implement build
    return Card(
        margin: EdgeInsets.all(12),
        child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 3.0,
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(width: 0.5, color: Colors.lightGreen)),
              child: ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, "/order_shop_list");
                    Route route = MaterialPageRoute(
                        builder: (BuildContext context) => OrderShopListPage(
                              products: orderItem.list.productsInCategory,
                            ));
                    Navigator.push(context, route);
                  },
                  title: Container(
                    height: 90.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new GroceryTitle(text: orderItem.id),
                        new GrocerySubtitle(text: orderItem.dtsubmit),
                      ],
                    ),
                  ),
                  trailing: new Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new GroceryTitle(text: orderItem.bprice + " AZN"),
                        // new RatingStarWidget(5, 0, 20),
                        _statusWidget(),
                        //new GrocerySubtitle(text: amount.toString()+" kq"),
                      ],
                    ),
                  )),
            )));
  }

  _statusWidget() {
    if (status) {
      return Text(
        "Deliverid",
        style: TextStyle(
            color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        "Processing",
        style: TextStyle(
            color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
  }
}
