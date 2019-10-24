import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:pin_code_view/pin_code_view.dart';

class PinCodePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PinCodePageState();
  }
}

class PinCodePageState extends State<PinCodePage> {
  String _pin;
  String _userName;
  String _password;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: PinCode(
        backgroundColor: Colors.lightGreen,
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
        correctPin: _pin,
        onCodeSuccess: (code) {
          print(code);
          loginThunkFunction(_userName, _password);
        },
        onCodeFail: (code) {
          print(code);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPrefUtil().getString(SharedPrefUtil().pinCode).then((onValue) {
      if (onValue.isNotEmpty) {
        SharedPrefUtil().getString(SharedPrefUtil().username).then((onValue) {
          _userName = onValue;
        });
        SharedPrefUtil().getString(SharedPrefUtil().password).then((onValue) {
          _password = onValue;
        });
        setState(() {
          _pin = onValue;
        });
      }
    });
  }
}
