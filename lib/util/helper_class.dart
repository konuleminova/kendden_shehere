import 'package:flutter/material.dart';
import 'package:kendden_shehere/main.dart';

void showSnackBar(String content) {
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(content),
      duration: Duration(seconds: 3),
      action: SnackBarAction(label: "Try Again", onPressed: () {}),
    ),
  );
}
