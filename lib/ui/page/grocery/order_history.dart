import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/common/model/order_history_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem4.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';
import 'package:kendden_shehere/util/util.dart';

class OrderHistoryPage extends StatelessWidget {
  List<OrderItem> orderItems = new List();
  AsyncMemoizer memoizer = new AsyncMemoizer();
  DateTime _selectedDate = new DateTime.now();
  var height;

  //BuildContext context;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

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
                    Text("From"),
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
                selectDateFromPicker(context);
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
                    Text("To"),
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
                selectDateFromPicker(context);
              },
            )
//            PopupMenuButton<String>(
//              icon: new Icon(Icons.date_range),
//              onSelected: choiceAction,
//              itemBuilder: (BuildContext context) {
//                return Constants.autodates.map((String choice) {
//                  return PopupMenuItem<String>(
//                      value: choice,
//                      child: new Container(
//                        child: new Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          children: <Widget>[
//                            Text(choice),
//                            new Icon(
//                              Icons.access_time,
//                              color: Colors.orange[700],
//                            )
//                          ],
//                        ),
//                      ));
//                }).toList();
//              },
//            ),
            ,
//            PopupMenuButton<String>(
//              icon: new Icon(Icons.filter_list),
//              onSelected: choiceAction,
//              itemBuilder: (BuildContext context) {
//                return Constants.orders.map((String choice) {
//                  return PopupMenuItem<String>(
//                    value: choice,
//                    child: new Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Text(choice),
//                        choice == "OrderProcessing"
//                            ? new Icon(
//                                Icons.sync_problem,
//                                color: Colors.red,
//                              )
//                            : new Icon(
//                                Icons.done,
//                                color: Colors.green,
//                              )
//                      ],
//                    ),
//                  );
//                }).toList();
//              },
//            ),
          ],
        ),
        body: FutureBuilder(
            future: memoizer.runOnce(Networks.orderHistory),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // OrderHistoryListModel order = snapshot.data;
                return new Container(
                    margin: EdgeInsets.only(
                        bottom: 16, top: 16, left: 10, right: 12),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NewGroceryListItemFour(snapshot.data[index]);
                        }));
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
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

  Future<Null> selectDateFromPicker(BuildContext context) async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

//      setState(() {
//        _selectedDate = selected;
//        selectedWeeksDays =
//            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//                .toList();
//        selectedMonthsDays = Utils.daysInMonth(selected);
//        displayMonth = Utils.formatMonth(selected);
//      });
//      Networks.updateUser(
//        context,
//        'dob',
//        _selectedDate.year.toString() +
//            " /" +
//            _selectedDate.month.toString() +
//            " /" +
//            _selectedDate.day.toString(),
//      );
      // updating selected date range based on selected week
//      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
//      _launchDateSelectionCallback(selected);
    }
  }
}
