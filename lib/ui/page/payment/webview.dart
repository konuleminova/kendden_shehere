import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  var kAndroidUserAgent =
      'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("WebView"),
      ),
      body: RaisedButton(
        onPressed: () {
          flutterWebViewPlugin.launch(
            "https://flutter.io",
            rect: Rect.fromLTWH(
                0.0, 0.0, MediaQuery.of(context).size.width, 300.0),
            userAgent: kAndroidUserAgent,
            invalidUrlRegex:
                r'^(https).+(twitter)', // prevent redirecting to twitter when user click on its icon in flutter website
          );
        },
        child: const Text('Open Webview (rect)'),
      ),
    );
  }
}
