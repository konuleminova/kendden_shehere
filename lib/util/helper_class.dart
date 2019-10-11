import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/main.dart';

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

Widget noInternetConnection() => Center(
        child: Container(
      child: Text(
        "No internet Connection",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.green),
    ));

Widget loading() => Center(
      child: new CircularProgressIndicator(),
    );
