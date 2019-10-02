import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/ui/page/payment/confirm_order.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

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
  bool _isOnTop = true;
  Checkout checkout = new Checkout();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

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
            padding: EdgeInsets.only(left: 8),
            child: ListTile(
              title: FutureBuilder(
                  future: _getAddress(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Text(
                      snapshot.hasData
                          ? snapshot.data
                          : "Please add new address",
                      style: TextStyle(color: Colors.grey),
                    );
                  }),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Route route = MaterialPageRoute(
                      builder: (BuildContext context) => MapPage1());
                  Navigator.push(context, route);
                },
              ),
            ),
            margin: EdgeInsets.all(16.0),
            color: Colors.white,
          ),
//          GestureDetector(
//            child: _getGoogleMap(),
//            onTap: _isOnTop ? _scrollToBottom : _scrollToTop,
//          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "images/map.png",
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red,
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
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
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
                      color: Colors.blue,
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
                //Navigator.pushNamed(context, "/confirm_order");

                //checkout.id = "382";
                checkout.address = "Baku Azerbaijan";
                checkout.delivery_place = "40.4093°,49.8671° ";
                checkout.delivery_price = "0";
                Route route = MaterialPageRoute(
                    builder: (BuildContext context) => ConfirmOrderPage(
                          checkout: checkout,
                        ));
                Navigator.push(context, route);
//                Networks.finishBasket(checkout).then((onValue) {
//                  if (onValue['done'] == "1") {
//                    if (onValue['redirectUrl'] != null) {
////                      Route route = MaterialPageRoute(
////                          builder: (BuildContext context) => WebViewPage(
////                                url: onValue['redirectUrl'],
////                              ));
////                      Navigator.push(context, route);
//                      flutterWebviewPlugin.onUrlChanged.listen((String url) {
//                        print("changed");
//                        print(url);
//                        print(onValue['redirectUrl']);
//                        if (url != onValue['redirectUrl']) {
//                          flutterWebviewPlugin.goBack();
//                          flutterWebviewPlugin.dispose();
//                          Navigator.pop(context);
//                          Navigator.pushNamed(context, "/shopping_cart");
//                        }
//
//                        //  Navigator.pushNamed(context, "/confirm_order");
//                      });
//                      print(onValue['redirectUrl']);
//                      flutterWebviewPlugin.launch(
//                        onValue['redirectUrl'],
//                        rect: Rect.fromLTWH(
//                            0.0,
//                            0.0,
//                            MediaQuery.of(context).size.width,
//                            MediaQuery.of(context).size.height),
//                        userAgent: kAndroidUserAgent,
//                        invalidUrlRegex:
//                            r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
//                      );
//                    } else {
//                      Navigator.pushNamed(context, "/shopping_cart");
//                    }
//                  }
//                });
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
    // flutterWebviewPlugin.close();
    super.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    setState(() => _isOnTop = true);
  }

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    setState(() => _isOnTop = false);
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
                            Icons.account_balance,
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
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    return await sharedPrefUtil.getString(SharedPrefUtil.address);
  }
}
