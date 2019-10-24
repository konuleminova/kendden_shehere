import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/home.dart';
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
          Networks().login(_userName, _password).then((onValue) {
            if (onValue != null) {
              SharedPrefUtil().setBool(SharedPrefUtil().isLoginKey, true);
              SharedPrefUtil().setString(SharedPrefUtil().uid, onValue.id);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HomePage(
                            fromCheckout: false,
                          )));
            }
          });
        },
        onCodeFail: (code) {
          Fluttertoast.showToast(
              msg: "Pin code is wrong.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
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
