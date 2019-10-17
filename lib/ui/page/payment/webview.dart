import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/home.dart';
//import 'package:webview_flutter/webview_flutter.dart';

//class WebViewPage extends StatefulWidget {
//  String url;
//
//  WebViewPage({this.url});
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return WebViewState();
//  }
//}

class WebViewPage extends StatelessWidget {
  String url;

  WebViewPage({this.url});
//  @override
//  void initState() {
//    super.initState();
//    //flutterWebViewPlugin.close();
//    final flutterWebviewPlugin = new FlutterWebviewPlugin();
//    flutterWebviewPlugin.onUrlChanged.listen((String url) {
//      print("printt"+url);
//      if (widget.url != url) {
//        flutterWebviewPlugin.close();
//        flutterWebviewPlugin.dispose();
//        Route route = MaterialPageRoute(
//            builder: (BuildContext context) => HomePage(
//                  fromCheckout: true,
//                ));
//
//        Navigator.pushReplacement(context, route);
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    // flutterWebViewPlugin.dispose();
//
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String urls) {
      print("printt"+urls);
      if (urls != url) {
        Route route = MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
              fromCheckout: true,
            ));

        Navigator.pushReplacement(context, route);
        flutterWebviewPlugin.close();
        flutterWebviewPlugin.dispose();
      }
    });
    // TODO: implement build
    return new WebviewScaffold(
        url:url,
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Payment'),
        ),
        withZoom: true,
        withLocalStorage: true,
        initialChild: Container(
          child: const Center(
            child: Text('Waiting.....'),
          ),
        ));
  }
}
