import 'package:flutter/material.dart';
import 'package:pin_code_view/pin_code_view.dart';

class PinCodePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PinCode(
      title: Text(
        "Lock Screen",
        style: TextStyle(
            color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),

      subTitle: Text(
        "Enter the pin code",
        style: TextStyle(color: Colors.white),
      ),
      codeLength: 6,
      // you may skip correctPin and plugin will give you pin as
      // call back of [onCodeFail] before it clears pin
      correctPin: "1234",
      onCodeSuccess: (code) {
        print(code);
      },
      onCodeFail: (code) {
        print(code);
      },
    );
  }
}