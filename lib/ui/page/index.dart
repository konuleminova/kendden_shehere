import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/page/login.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class _IndexPageState extends State<IndexPage> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Image.asset(
            "images/ks/splash.png",
            fit: BoxFit.contain,
          ))
    );
  }

  @override
  void initState() {
    super.initState();

    SharedPrefUtil().getBool(SharedPrefUtil().isLoginKey).then((onValue) {
      isLogin=onValue;
      if (!onValue) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                      fromCheckout: false,
                    )));
      }
    });
  }
}

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndexPageState();
  }
}
