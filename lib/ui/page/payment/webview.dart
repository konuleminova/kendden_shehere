import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class WebViewPage extends StatelessWidget {
  String url;

  WebViewPage({this.url});

  @override
  Widget build(BuildContext context) {
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String urls) {
      print("printt" + urls);
      if (urls == 'https://kendden.az/') {
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
        url: url,
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(AppTranslations.of(context).text('payment')),
        ),
        withZoom: true,
        withLocalStorage: true,
        initialChild: Container(child: loading()));
  }
}
