import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;

  WebViewPage({this.url});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WebViewState();
  }
}

class WebViewState extends State<WebViewPage> {
//  final Completer<WebViewController> _controller =
//      Completer<WebViewController>();
  //final flutterWebViewPlugin = FlutterWebviewPlugin();
  var kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  @override
  void initState() {
    super.initState();
    //flutterWebViewPlugin.close();
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print(url);
      if (widget.url != url) {
        flutterWebviewPlugin.close();
        flutterWebviewPlugin.dispose();
        Route route = MaterialPageRoute(
            builder: (BuildContext context) => GroceryShopCartPage(
                  fromCheckout: true,
                ));

        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  void dispose() {
    // flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
        url: widget.url,
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: const Text('Payment'),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          child: const Center(
            child: Text('Waiting.....'),
          ),
        ));
  }
}
