import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/ui/page/map/searchplace.dart';
import 'package:kendden_shehere/ui/page/payment/confirm_order.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:intl/intl.dart';

class CheckoutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CheckoutsPageState();
  }
}

class CheckoutsPageState extends State<CheckoutsPage> {
  var selectedIndex = 0;
  String choice = Constants.deliveryTimes[0];
  ScrollController _scrollController;
  Checkout checkout = new Checkout();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _text = "";
  DateFormat dateFormat = new DateFormat.Hm();
  DateTime now = DateTime.now();
  DateTime open;
  DateTime close;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    checkout.dpayment_selected_val = "online";
    checkout.dtime_selected_val = choice;
    open = dateFormat.parse("11:30");
    open = new DateTime(now.year, now.month, now.day, open.hour, open.minute);
    close = dateFormat.parse("19:30");
    close =
        new DateTime(now.year, now.month, now.day, close.hour, close.minute);
    if (now.isAfter(open)) {
      _text = "Odenishiniz sabah yerine yetirelecek";
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: greenFixed,
        title: Text(AppTranslations.of(context).text("checkout")),
        centerTitle: true,
      ),
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          _getAccountTypeSection(),
          _getAddressWidget(),
          checkout.dtime_selected_val != Constants.deliveryTimes[3]
              ? Container(
                  margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
                  child: Column(
                    children: <Widget>[
                      _getGoogleMap(),
                      _getDropDown(),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 20,
                            color: const Color(0xFFFDB2B4),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                AppTranslations.of(context).text('amount_1'),
                              ),
                              width: 250,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              width: 20,
                              height: 20,
                              color: const Color(0xFFAAD47D)),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                AppTranslations.of(context).text('amount_2'),
                              ),
                              width: 250,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 20,
                            color: const Color(0xFFF8D986),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                AppTranslations.of(context).text('amount_3'),
                              ),
                              width: 250,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : SizedBox(
                  height: 10,
                ),
          Align(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(30.0),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                color: greenFixed,
                disabledColor: greenFixed,
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Text(
                  AppTranslations.of(context).text('next'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (checkout.dtime_selected_val !=
                      Constants.deliveryTimes[3]) {
                    SharedPrefUtil()
                        .getString(SharedPrefUtil().address)
                        .then((onValue) {
                      if (onValue.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                            content: Text(
                              AppTranslations.of(context).text('please_fill'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                _scaffoldKey.currentState.hideCurrentSnackBar();
                                // Some code to undo the change.
                              },
                            ),
                            backgroundColor: Colors.red));
                      } else {
                        Route route = MaterialPageRoute(
                            builder: (BuildContext context) => ConfirmOrderPage(
                                  checkout: checkout,
                                ));
                        Navigator.push(context, route);
                      }
                    });
                  } else {
                    Route route = MaterialPageRoute(
                        builder: (BuildContext context) => ConfirmOrderPage(
                              checkout: checkout,
                            ));
                    Navigator.push(context, route);
                  }
                },
              ),
            ),
            alignment: AlignmentDirectional(0, 0.5),
          )
        ],
      ),
    );
  }

  Widget _getAccountTypeSection() {
    return Container(
      height: 90.0,
      margin: EdgeInsets.only(left: 16,right: 16,top: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTapUp: (tapDetail) {
                selectedIndex = 0;

                setState(() {
                  checkout.dpayment_selected_val = "online";
                });
              },
              child: Container(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: selectedIndex == 1
                              ? Image.asset('images/ks/radio2.png')
                              : Image.asset('images/ks/radio1.png'),
                          onTap: null,
                        ),
                        GestureDetector(
                          child: Image.asset('images/ks/credit_card.png'),
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    child: Text(
                        AppTranslations.of(context).text('online_payment')),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                  )
                ],
              )),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTapUp: (tapDetail) {
                selectedIndex = 1;

                setState(() {
                  checkout.dpayment_selected_val = "offline";
                });
              },
              child: Container(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: selectedIndex == 1
                              ? Image.asset('images/ks/radio1.png')
                              : Image.asset('images/ks/radio2.png'),
                          onTap: null,
                        ),
                        GestureDetector(
                          child: Image.asset('images/ks/wallet.png'),
                          onTap: null,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    child:
                        Text(AppTranslations.of(context).text('on_delivery')),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }

  _getDropDown() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Container(
//              height: 42.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      child: PopupMenuButton<String>(
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return Constants.deliveryTimes.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                          child: new Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 8,right: 8,top: 4),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: greenFixed))),
                             // padding: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        AppTranslations.of(context)
                                            .text('delivery_time'),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      Text(
                                        choice,
                                        style: TextStyle(
                                            fontSize: 14.0,color: Colors.grey),
                                      ),
                                      SizedBox(height: 8,)
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: greenFixed,
                                    ),
                                    alignment: Alignment.centerRight,
                                  ))
                                ],
                              ))),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left:1,right: 8),
                      padding: EdgeInsets.all(8),
                      child: Text(_text,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.0,
                              color: choice != Constants.deliveryTimes[2]
                                  ? Colors.green
                                  : Colors.redAccent)),
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  void choiceAction(String choice) {
    setState(() {
      this.choice = choice;
      checkout.dtime_selected_val = choice;
      if (choice == Constants.deliveryTimes[0]) {
        if (now.isAfter(open)) {
          _text = "Odenishiniz sabah yerine yetirelecek.";
        } else {
          _text = "";
        }
      } else if (choice == Constants.deliveryTimes[1]) {
        if (now.isAfter(close)) {
          _text = "Odenishiniz sabah yerine yetirelecek.";
        } else {
          _text = "";
        }
      } else if (choice == Constants.deliveryTimes[2]) {
        _text = AppTranslations.of(context).text('fast_delivery2');
      } else {
        _text = "";
      }
    });
  }

  _getGoogleMap() => checkout.dtime_selected_val != "Magazadan gotur"
      ? MapPage1()
      : SizedBox();

  _getAddress() async {
    return await SharedPrefUtil().getString(SharedPrefUtil().address);
  }

  _getAddressWidget() => checkout.dtime_selected_val !=
          Constants.deliveryTimes[3]
      ? GestureDetector(
          child: Container(
              child: Card(
                child: Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppTranslations.of(context).text('address'),
                          style: TextStyle(color: Colors.grey),
                        ),
                        FutureBuilder(
                            future: _getAddress(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Text(
                                snapshot.hasData && snapshot.data != ""
                                    ? snapshot.data
                                    : AppTranslations.of(context)
                                        .text('new_address'),
                                style: TextStyle(color: Colors.grey),
                              );
                            }),
                      ],
                    ),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: greenFixed)))),
                elevation: 2,
              ),
              margin: EdgeInsets.only(left: 12, right: 12, bottom: 8)),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    Dialog(child: CustomSearchScaffold()));
          },
        )
      : SizedBox(
          height: 10,
        );
}
