import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/payment/webview.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/util/helper_class.dart';
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
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  Checkout checkout;
  String alkaqol;

  getSharedPref() async {
    checkout.mobile = await SharedPrefUtil().getString(SharedPrefUtil().mobile);
    checkout.username =
        await SharedPrefUtil().getString(SharedPrefUtil().username);
    checkout.id = await SharedPrefUtil().getString(SharedPrefUtil().id);
    alkaqol = await SharedPrefUtil().getString(SharedPrefUtil().alkaqol);
    checkout.address =
        await SharedPrefUtil().getString(SharedPrefUtil().address);
    checkout.delivery_place =
        await SharedPrefUtil().getString(SharedPrefUtil().coordinates);
    checkout.delivery_price =
        await SharedPrefUtil().getString(SharedPrefUtil().price);
    return checkout;
  }

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.close();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Information"),
          content: new Text(
            "Sale of alcoholic beverages by PORTAL to minors (persons below 18 years of age) is prohibited. When a customer orders an order, ALICI's identity will be determined in the appropriate document (ID card). If ALICI is under 18 years of age, the sale of goods to the customer will be stopped.",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Accept"),
              onPressed: () {
                Navigator.of(context).pop();
                _finishBAsket();
              },
            ),
          ],
        );
      },
    );
  }

  _finishBAsket() {
    if (checkout.dtime_selected_val == "11:30-13:00") {
      checkout.dtime_selected_val = "11";
    } else if (checkout.dtime_selected_val == "13:00-19:30") {
      checkout.dtime_selected_val = "19";
    } else if (checkout.dtime_selected_val == "Tecili catdirilma") {
      checkout.dtime_selected_val = "T";
    } else {
      checkout.dtime_selected_val = "N";
    }
    Networks().finishBasket(checkout).then((onValue) {
      if (onValue['done'] == "1") {
        if (onValue['redirectUrl'] != null) {
          Route route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  WebViewPage(url: onValue['redirectUrl']));
          Navigator.push(context, route);
        } else {
          Route route = MaterialPageRoute(
              builder: (BuildContext context) => GroceryShopCartPage(
                    fromCheckout: true,
                  ));

          Navigator.pushReplacement(context, route);
        }
      }
    });
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
                  return SingleChildScrollView(
                    child: Column(
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
                            color: Colors.green,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (buildContext) {
                                    return ProfileEditDialog("mobile");
                                  });
                            },
                          ),
                        ),
                        Divider(),
                      //  Divider(),
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

                        Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text("Subtotal Price"),
                                  trailing: Text(
                                    checkout.delivery_price + " AZN",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Delivery Price"),
                                  trailing: Text(
                                    checkout.delivery_price + " AZN",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Tecili catdirilma",style: TextStyle(color: Colors.red),),
                                  trailing: Text(
                                    checkout.delivery_price + " AZN",
                                    style: TextStyle(fontSize: 15,color: Colors.red),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Total Price",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                                  trailing: Text(
                                    checkout.delivery_price + " AZN",
                                    style: TextStyle(fontSize: 15,color: Colors.green,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                            ],
                          ),
                          height: 120,
                        ),
                        SizedBox(height: 16,),
                        RaisedButton(
                          color: Colors.green,
                          onPressed: () {
                            if (checkout.mobile.isEmpty ||
                                checkout.address.isEmpty) {
                              // Find the Scaffold in the widget tree and use
                              // it to show a SnackBar.
                              Scaffold.of(context).showSnackBar(
                                  snackBar("Please fill all fields."));
                            } else {
                              if (alkaqol == "1") {
                                _showDialog();
                              } else {
                                _finishBAsket();
                              }
                            }
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
                    ),
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
