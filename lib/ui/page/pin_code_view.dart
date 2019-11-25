import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kendden_shehere/constants/Constants.dart';
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
      backgroundColor: greenFixed,
      body: PinCode(
        backgroundColor: greenFixed,
        title: Text(
          "Verify Account",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),

        subTitle: Text(
          "Please send verification code we sent to your phone number",
          style: TextStyle(color: Colors.white,fontSize: 18,),
          textAlign: TextAlign.center,
        ),
        codeLength: 6,
        // you may skip correctPin and plugin will give you pin as
        // call back of [onCodeFail] before it clears pin
        correctPin: _pin,
        onCodeSuccess: (code) {
          print(code);
          Networks().login(_userName, _password).then((onValue) async {
            if (onValue != null) {
              await SharedPrefUtil().setBool(SharedPrefUtil().isLoginKey, true);
              await SharedPrefUtil()
                  .setString(SharedPrefUtil().uid, onValue.id)
                  .then((onValue) {
                Networks().updateUser(context, 'sms', '1');
              });
              await SharedPrefUtil()
                  .setString(SharedPrefUtil().name, onValue.name);
              await SharedPrefUtil()
                  .setString(SharedPrefUtil().surname, onValue.surname);
              await SharedPrefUtil()
                  .setString(SharedPrefUtil().mobile, onValue.mobile);
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
          Networks().updateUser(context, 'sms', '0');
          Fluttertoast.showToast(
              msg: "Pin code is wrong.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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
