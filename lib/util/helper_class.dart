import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/page/home.dart';

void showSnackBar(String content, GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(content),
      duration: Duration(seconds: 3),
      action: SnackBarAction(label: "Try Again", onPressed: () {}),
    ),
  );
}

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
}

snackBar(content) => SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: 'Try again',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

Widget noInternetConnection() => Container(
      child: Column(
        children: <Widget>[
          IconButton(icon: Icon(Icons.signal_wifi_off,size: 30,),onPressed: null,),
          Text(
            "Slow or no internet connection.",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Please check your internet settings",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text(
              "Try Again",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: null,
            disabledColor: Colors.teal,
          )
        ],
      ),
    );

Widget loading() => Center(
      child: new CircularProgressIndicator(),
    );
