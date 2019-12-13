import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/page/home.dart';

class _SplashPageState extends State<SplashPage> {
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
            )));
  }

  @override
  void initState() {
    super.initState();
    getBool().then((onValue) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePage(
                    fromCheckout: false,
                  )));
    });
  }

  Future<bool> getBool() async {
    // sleep(const Duration(seconds:5));
    await Future.delayed(Duration(milliseconds: 1200));
    return true;
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashPageState();
  }
}
