import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/ui/page/map/searchplace.dart';
import 'package:kendden_shehere/ui/page/payment/confirm_order.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class CheckoutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CheckoutsPageState();
  }
}

class CheckoutsPageState extends State<CheckoutsPage> {
  var selectedIndex = 0;
  String choice = "11:30-13:00";
  ScrollController _scrollController;
  Checkout checkout = new Checkout();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Checkout"),
        centerTitle: true,
      ),
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          _getAccountTypeSection(),
          _getDropDown(),
          new Container(
            margin: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Unvan',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
          ),
          Container(
            child: Card(
              child: ListTile(
                title: FutureBuilder(
                    future: _getAddress(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        snapshot.hasData && snapshot.data != ""
                            ? snapshot.data
                            : "Please add new address",
                        style: TextStyle(color: Colors.grey),
                      );
                    }),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed:null
                ),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          Dialog(child: CustomSearchScaffold()));
                },
              ),
              elevation: 2,
            ),
            margin: EdgeInsets.only(left: 12,right: 12,bottom: 8)
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: Column(
              children: <Widget>[
                _getGoogleMap(),
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
                          "Delivery amount 4 AZN.When ordering from 20 AZN delivery is free. ",
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
                        width: 20, height: 20, color: const Color(0xFFAAD47D)),
                    SizedBox(
                      width: 5.0,
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          "Delivery amount 4 AZN.",
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
                          "Delivery amount 7 AZN. ",
                        ),
                        width: 250,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          new Container(
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (BuildContext context) => ConfirmOrderPage(
                          checkout: checkout,
                        ));
                Navigator.push(context, route);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("NEXT", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          )
        ],
      ),
    );
  }

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
  }

  Widget _getAccountTypeSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Container(
          height: 60.0,
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
                        stops: [0.0, 0.5],
                        colors: selectedIndex == 0
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
                                Color(0xFF47E497),
                                Color(0xFF47E0D6)
                              ]
                            : [Colors.white, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.credit_card,
                            color: selectedIndex == 0
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Online\nOdenish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
                        stops: [0.0, 0.5],
                        colors: selectedIndex == 1
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
                                Color(0xFF47E497),
                                Color(0xFF47E0D6)
                              ]
                            : [Colors.white, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_wallet,
                            color: selectedIndex == 1
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Yerinde\nOdenish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDropDown() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Text(
                'Catdirilma vaxti',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Container(
//              height: 42.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 8),
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
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListTile(
                                title: Text(
                                  choice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                                trailing: new Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                ),
                              ))),
                    ),
                    new Container(
                      padding: EdgeInsets.all(12),
                      child: (choice == "Tecili catdirilma")
                          ? Text('Təcili sifarişlərə 2 AZN əlavə tətbiq olunur',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.redAccent))
                          : new SizedBox(
                              height: 0,
                              width: 0,
                            ),
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
    });
  }

  _getGoogleMap() => MapPage1();

  _getAddress() async {
    return await SharedPrefUtil().getString(SharedPrefUtil().address);
  }
}
