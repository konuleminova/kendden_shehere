import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class ConfirmOrderPage extends StatefulWidget {
  Checkout checkout;

  ConfirmOrderPage({this.checkout});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConfirmPageState();
  }
}

class ConfirmPageState extends State<ConfirmOrderPage> {
  SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  Checkout checkout;

  getSharedPref() async {
    checkout.mobile = await sharedPrefUtil.getString(SharedPrefUtil.mobile);
    checkout.username = await sharedPrefUtil.getString(SharedPrefUtil.username);
    checkout.id = await sharedPrefUtil.getString(SharedPrefUtil.id);
    return checkout;
  }


  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkout = widget.checkout;
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text("Confirm Order"),
        ),
        body: Container(
          child: FutureBuilder(
              future: getSharedPref(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Delivery Address"),
                        subtitle: Text(checkout.address),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: null,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Mobile"),
                        subtitle: Text(checkout.mobile),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: null,
                        ),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Price"),
                        subtitle: Text(checkout.delivery_price),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Username"),
                        subtitle: Text(checkout.username),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Time"),
                        subtitle: Text(checkout.dtime_selected_val),
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Payment Option"),
                        subtitle: Text(checkout.dpayment_selected_val),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          Networks.finishBasket(checkout).then((onValue) {
                            if (onValue['done'] == "1") {
                              if (onValue['redirectUrl'] != null) {
//                      Route route = MaterialPageRoute(
//                          builder: (BuildContext context) => WebViewPage(
//                                url: onValue['redirectUrl'],
//                              ));
//                      Navigator.push(context, route);
                                flutterWebviewPlugin.onUrlChanged
                                    .listen((String url) {
                                  if (url != onValue['redirectUrl'] ) {
                                    print("CHNAGED");
                                    Navigator.pop(context);
                                    flutterWebviewPlugin.close();
                                    flutterWebviewPlugin.dispose();
                                   // flutterWebviewPlugin.goBack();
                                   // flutterWebviewPlugin.goBack();
//                                    flutterWebviewPlugin.dispose();
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, "/shopping_cart");
                                  }

                                  //  Navigator.pushNamed(context, "/confirm_order");
                                });
                                print(onValue['redirectUrl']);
                                flutterWebviewPlugin.launch(
                                  onValue['redirectUrl'] ,
                                  rect: Rect.fromLTWH(
                                      0.0,
                                      0.0,
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height),
                                  userAgent: kAndroidUserAgent,
                                  invalidUrlRegex:
                                      r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
                                );
                              } else {
                                Navigator.pushNamed(context, "/shopping_cart");
                              }
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Confirm Order",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          margin: EdgeInsets.all(16.0),
        ));
  }
}
