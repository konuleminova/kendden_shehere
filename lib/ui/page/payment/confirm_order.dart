import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/page/payment/webview.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_error_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;

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
    checkout.price = await SharedPrefUtil().getString(SharedPrefUtil().price);
    checkout.deliveryPrice =
        await SharedPrefUtil().getString(SharedPrefUtil().deliveryPrice);
    if (checkout.dtime_selected_val == "Tecili catdirilma") {
      checkout.teciliCatdirlma = "2";
    } else {
      checkout.teciliCatdirlma = null;
    }
    if (checkout.dtime_selected_val == "Magazadan gotur") {
      checkout.deliveryPrice = "0";
    }
    checkout.total = (double.parse(checkout.price) +
            double.parse(checkout.deliveryPrice) +
            (checkout.teciliCatdirlma != null
                ? double.parse(checkout.teciliCatdirlma)
                : 0))
        .toString();
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
          title: new Text(AppTranslations.of(context).text("info")),
          content: new Text(
            AppTranslations.of(context).text("saleof"),
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog

            new FlatButton(
              child: new Text(AppTranslations.of(context).text("close")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(AppTranslations.of(context).text("accept")),
              onPressed: () {
                Navigator.of(context).pop();
                _finishBAsket(this.context);
              },
            ),
          ],
        );
      },
    );
  }

  _finishBAsket(BuildContext context) {
    if (checkout.dtime_selected_val == "11:30-13:00") {
      checkout.dtime_selected_val = "11";
    } else if (checkout.dtime_selected_val == "13:00-19:30") {
      checkout.dtime_selected_val = "19";
    } else if (checkout.dtime_selected_val == "Tecili catdirilma") {
      checkout.dtime_selected_val = "T";
      checkout.teciliCatdirlma = "2";
    } else {
      checkout.dtime_selected_val = "N";
    }
    Networks().finishBasket(checkout).then((onValue) {
      if (onValue['done'] == "1") {
        if (onValue['redirectUrl'] != null) {
          // Navigator.pop(context);
          Route route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  WebViewPage(url: onValue['redirectUrl']));
          Navigator.pushReplacement(context, route);
        } else {
          // Navigator.pop(context);
          Route route = MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                    fromCheckout: true,
                  ));

          Navigator.pushReplacement(context, route);
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: Text(
              onValue.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red));
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
    this.context=context;
    checkout = widget.checkout;
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: greenFixed,
          title: Text("Confirm Order"),
        ),
        body: Container(
          child: FutureBuilder(
              future: getSharedPref(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.deliveryPrice != "-1"
                      ? SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(AppTranslations.of(context)
                                    .text('address')),
                                subtitle: Text(checkout.address),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: null,
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Text(
                                    AppTranslations.of(context).text('mobile')),
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
                              //  Divider(),
                              ListTile(
                                title: Text(AppTranslations.of(context)
                                    .text('username')),
                                subtitle: Text(checkout.username),
                              ),
                              Divider(),
                              ExpansionTile(
                                title: Text(AppTranslations.of(context)
                                    .text('delivery_time')),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(checkout.dtime_selected_val),
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                title: Text(AppTranslations.of(context)
                                    .text('payment_option')),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(checkout.dpayment_selected_val),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text('sub_total_price')),
                                        trailing: Text(
                                          checkout.price + " AZN",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(AppTranslations.of(context)
                                            .text('delivery_price')),
                                        trailing: Text(
                                          checkout.deliveryPrice + " AZN",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    checkout.teciliCatdirlma != null
                                        ? Expanded(
                                            child: ListTile(
                                              title: Text(
                                                AppTranslations.of(context)
                                                    .text('fast_delivery1'),
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              trailing: Text(
                                                checkout.teciliCatdirlma +
                                                    " AZN",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          AppTranslations.of(context)
                                              .text('total_price'),
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Text(
                                          checkout.total + " AZN",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                height: 120,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                  child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(30.0),
                                      child: RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          color: greenFixed,
                                          disabledColor: greenFixed,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40.0))),
                                          child: Text(
                                            AppTranslations.of(context)
                                                .text('confirm_order'),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            if (checkout.mobile.isEmpty) {
                                              // Find the Scaffold in the widget tree and use
                                              // it to show a SnackBar.
                                              Scaffold.of(context).showSnackBar(
                                                  snackBar(AppTranslations.of(
                                                          context)
                                                      .text('please_fill')));
                                            } else {
                                              if (alkaqol == "1") {
                                                _showDialog();
                                              } else {
                                                _finishBAsket(this.context);
                                              }
                                            }
                                          }))),
//                              RaisedButton(
//                                color: Colors.green,
//                                onPressed: () {
//                                  if (checkout.mobile.isEmpty) {
//                                    // Find the Scaffold in the widget tree and use
//                                    // it to show a SnackBar.
//                                    Scaffold.of(context).showSnackBar(snackBar(
//                                        AppTranslations.of(context)
//                                            .text('please_fill')));
//                                  } else {
//                                    if (alkaqol == "1") {
//                                      _showDialog();
//                                    } else {
//                                      _finishBAsket();
//                                    }
//                                  }
//                                },
//                                child: Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceAround,
//                                  children: <Widget>[
//                                    Text(
//                                        AppTranslations.of(context)
//                                            .text('confirm_order'),
//                                        style: TextStyle(color: Colors.white)),
//                                  ],
//                                ),
//                              )
                            ],
                          ),
                        )
                      : FutureBuilder(
                          future: Future.delayed(
                              Duration.zero,
                              () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PaymentErrorDialog(
                                        context,
                                        "Catdirilma yoxdur!",
                                        AppTranslations.of(context)
                                            .text('amount_4'));
                                  })),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Container();
                          });
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
