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
        child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset('images/ks/sorry.png'),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 50,
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.bottomCenter,
            ))
      ],
    ));

Widget loading() => Center(
      child: new CircularProgressIndicator(),
    );
