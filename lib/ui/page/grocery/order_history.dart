import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/common/model/order_history_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistrory_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem4.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';
import 'package:kendden_shehere/util/util.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderHistoryState();
  }
}

class OrderHistoryState extends State<OrderHistoryPage> {
  AsyncMemoizer memoizer = new AsyncMemoizer();
  DateTime _selectedDate = new DateTime.now();
  String from = "From";
  String to = "To";
  OrderHistoryListModel order;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(AppTranslations.of(context).text("order_history")),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.only(left: 10),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(from),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: null,
                      color: Colors.white,
                      disabledColor: Colors.white,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300])),
              ),
              onTap: () {
                selectDateFromPickerFrom(context);
              },
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.only(left: 10),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(to),
                    IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: null,
                      color: Colors.white,
                      disabledColor: Colors.white,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[300])),
              ),
              onTap: () {
                selectDateFromPickerTo(context);
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: memoizer.runOnce(Networks.orderHistory),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                order = snapshot.data;
                List<OrderHistoryModel> orderList = new List();

                for (int i = 0; i < order.orderList.length; i++) {
                  DateTime dateTime =
                      DateTime.parse(order.orderList[i].dtsubmit);
                  if (_selectedDate.isBefore(dateTime)) {
                    orderList.add(order.orderList[i]);
                  } else {
                    orderList.clear();
                  }
                }
                return new Container(
                    margin: EdgeInsets.only(
                        bottom: 16, top: 16, left: 10, right: 12),
                    child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewGroceryListItemFour(orderList[index]);
                        }));
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
  }

  Future<Null> selectDateFromPickerFrom(BuildContext context) async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = selected;
        from = _selectedDate.day.toString() +
            "/" +
            _selectedDate.month.toString() +
            "/" +
            _selectedDate.year.toString();
      });
    }
  }

  Future<Null> selectDateFromPickerTo(BuildContext context) async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );
    if (selected != null) {
      setState(() {
        _selectedDate = selected;
        to = _selectedDate.day.toString() +
            "/" +
            _selectedDate.month.toString() +
            "/" +
            _selectedDate.year.toString();
      });
    }
  }
}
