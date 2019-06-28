import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/model/order_history_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem3.dart';

class OrderHistoryPage extends StatelessWidget {
  List<OrderItem> orderItems = new List();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    context = this.context;
    orderItems.add(
      new OrderItem(
          title: "Order Name",
          subtitle: "27.02.2019",
          price: "1 AZN",
          status: true),
    );
    orderItems.add(
      new OrderItem(
          title: "Order Name",
          subtitle: "28.05.2019",
          price: "1 AZN",
          status: false),
    );
    orderItems.add(
      new OrderItem(
          title: "Order Name",
          subtitle: "1.02.2019",
          price: "1 AZN",
          status: false),
    );
    orderItems.add(
      new OrderItem(
          title: "Order Name",
          subtitle: "3.04.2019",
          price: "1 AZN",
          status: true),
    );
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: new Text("Order History"),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: new Icon(Icons.date_range),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.autodates.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice,
                    child: new Container(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(choice),
                          new Icon(
                            Icons.access_time,
                            color: Colors.orange[700],
                          )
                        ],
                      ),
                    ));
              }).toList();
            },
          ),
          PopupMenuButton<String>(
            icon: new Icon(Icons.filter_list),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.orders.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(choice),
                      choice == "OrderProcessing"
                          ? new Icon(
                              Icons.sync_problem,
                              color: Colors.red,
                            )
                          : new Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _shopBody()),
          SizedBox(
            height: 10.0,
          ),
          // _buildTotals()
        ],
      ),
    );
  }

  static void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      print('I First Item');
    } else if (choice == Constants.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants.ThirdItem) {
      print('I Thired Item');
    }
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: orderItems
              .map((OrderItem orderItem) => _builOrderListItem(orderItem))
              .toList(),
        ),
      );

  Widget _builOrderListItem(OrderItem orderItem) => GestureDetector(
        child: new Stack(
          children: <Widget>[
            GroceryListItemThree(new OrderItem(
                title: orderItem.title,
                subtitle: orderItem.subtitle,
                status: orderItem.status,
                amount: 1,
                price: orderItem.price)),
          ],
        ),
        onTap: () {},
      );
}
