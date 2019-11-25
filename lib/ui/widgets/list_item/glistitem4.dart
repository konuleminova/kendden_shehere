import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistrory_model.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/grocery/order_shop_list.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';

class GroceryListItemFour extends StatefulWidget {
  OrderHistoryModel orderItem;

  GroceryListItemFour(this.orderItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroceryListItemFourState();
  }
}

class GroceryListItemFourState extends State<GroceryListItemFour> {
  OrderHistoryModel orderItem;
  int amount;

  @override
  Widget build(BuildContext context) {
    orderItem = widget.orderItem;

    // TODO: implement build
    return Card(
        margin: EdgeInsets.all(12),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: new Container(
            height: MediaQuery.of(context).size.height * 0.35,
            //margin: EdgeInsets.only(top: 8),
            decoration: new BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          "Order #" + orderItem.id,
                          style: TextStyle(
                              fontSize: 16,
                              color: greenFixed,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      new Text(
                        orderItem.dtsubmit,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                )),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 0,left: 16,right: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(orderItem.list.productsInCategory[0].name_en),
                            Text(orderItem.list.productsInCategory[0].weight.toString()+" piece"),
                          ],
                        ),
                        Divider(color: greenFixed,),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(orderItem.list.productsInCategory[0].name_en),
                            Text(orderItem.list.productsInCategory[0].weight.toString()+" piece"),
                          ],
                        ),
                        Divider(color: greenFixed,),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(orderItem.list.productsInCategory[0].name_en),
                            Text(orderItem.list.productsInCategory[0].weight.toString()+" piece"),
                          ],
                        ),
                        Divider(color: greenFixed,),

                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: greenFixed),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Üzeyir Hajibeyov str., 84",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total",
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              orderItem.bprice + " AZN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ))
              ],
            )));
  }

  _statusWidget(String string) {
    if (string == "finished") {
      return Text(
        string,
        style: TextStyle(
            color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        string,
        style: TextStyle(
            color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      );
    }
  }
}
