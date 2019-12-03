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

Widget noData(String text) => Container(
    height: 300,
    width: 300,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Align(
          child: Image.asset('images/ks/sorry.png'),
          alignment: Alignment.center,
        ),
        Align(
            alignment: Alignment.center,
            child: Container(
              width: 150,
              height: 160,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.bottomCenter,
            ))
      ],
    ));

Widget loading() => Center(
      child: new CircularProgressIndicator(),
    );
