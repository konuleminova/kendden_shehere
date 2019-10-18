import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistrory_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem4.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderHistoryState();
  }
}

class OrderHistoryState extends State<OrderHistoryPage> {
  AsyncMemoizer memoizer = new AsyncMemoizer();
  DateTime _selectedDateFrom = new DateTime.now();
  DateTime _selectedDateTo = new DateTime.now();
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
            future: memoizer.runOnce((){
             return Networks().orderHistory();
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                order = snapshot.data;
                List<OrderHistoryModel> orderList = new List();
                if (to == "To" && from == "From") {
                  orderList.addAll(snapshot.data.orderList);
                } else if (to != "To" && from == "From") {
                  orderList.clear();
                  for (int i = 0; i < order.orderList.length; i++) {
                    DateTime dateTime =
                        DateTime.parse(order.orderList[i].dtsubmit);
                    if (_selectedDateTo.isAfter(dateTime)) {
                      orderList.add(order.orderList[i]);
                    } else {
                      //orderList.clear();
                    }
                  }
                } else if (from != "From" && to == "To") {
                  orderList.clear();
                  for (int i = 0; i < order.orderList.length; i++) {
                    DateTime dateTime =
                        DateTime.parse(order.orderList[i].dtsubmit);
                    if (_selectedDateFrom.isBefore(dateTime)) {
                      orderList.add(order.orderList[i]);
                    } else {
                      //orderList.clear();
                    }
                  }
                } else {
                  orderList.clear();
                  for (int i = 0; i < order.orderList.length; i++) {
                    DateTime dateTime =
                        DateTime.parse(order.orderList[i].dtsubmit);
                    if (_selectedDateFrom.isBefore(dateTime) &&
                        _selectedDateTo.isAfter(dateTime)) {
                      orderList.add(order.orderList[i]);
                    } else {
                      //orderList.clear();
                    }
                  }
                }

                return new Container(
                    margin: EdgeInsets.only(
                        bottom: 16, top: 16, left: 10, right: 12),
                    child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GroceryListItemFour(orderList[index]);
                        }));
              } else if(snapshot.connectionState==ConnectionState.waiting){
                return loading();
              }else{
                return Container();
              }

            }));
  }

  Future<Null> selectDateFromPickerFrom(BuildContext context) async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDateFrom ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );
    if (selected != null) {
      setState(() {
        _selectedDateFrom = selected;
        from = _selectedDateFrom.day.toString() +
            "/" +
            _selectedDateFrom.month.toString() +
            "/" +
            _selectedDateFrom.year.toString();
      });
    }
  }

  Future<Null> selectDateFromPickerTo(BuildContext context) async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDateTo ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );
    if (selected != null) {
      setState(() {
        _selectedDateTo = selected;
        to = _selectedDateTo.day.toString() +
            "/" +
            _selectedDateTo.month.toString() +
            "/" +
            _selectedDateTo.year.toString();
      });
    }
  }
}
