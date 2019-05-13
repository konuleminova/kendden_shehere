import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnlineChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new OnlineChatPageState();
  }
}

class OnlineChatPageState extends State<OnlineChatPage> {
  String _chatMessage = "initial";

  @override
  void initState() {
    super.initState();
    _getOnlineChatSdk();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Online Chat"),
          backgroundColor: Colors.lightGreen,
        ),
        body: new Center(
          child: new Container(
            child: new Text(_chatMessage),
          ),
        ));
  }

  static const chatChannel = const MethodChannel("kendden_shehere/chat");

  Future<void> _getOnlineChatSdk() async {
    String chatMessage="chat msg";
    print("click");
    try {
      var result = await chatChannel.invokeMethod("chatMethod");
      print("result");
      chatMessage = "Chat Message at" + result;
    } on PlatformException catch (e) {
      chatMessage = "error platform exception";
    }
    print(chatMessage);
    setState(() {
      _chatMessage = chatMessage;
    });
  }
}
