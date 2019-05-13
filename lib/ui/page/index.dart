import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/ui/page/login.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLoggedIn = false;
  bool progress = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
        future: SharedPrefUtil().getUserHasLogin(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              isLoggedIn = snapshot.data;
              if (isLoggedIn) {
                return HomePage();
              } else {
                return LoginPage();
              }
            }
          } else {
            // default show loading while state is waiting
            return _loadingView;
          }
        },
      ),
    );
  }

   Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }
}
