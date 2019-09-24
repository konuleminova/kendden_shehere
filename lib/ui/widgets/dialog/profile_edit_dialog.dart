import 'package:flutter/material.dart';
import 'package:kendden_shehere/service/networks.dart';

class ProfileEditDialog extends StatelessWidget {
  String text;

  TextEditingController _textController = new TextEditingController();

  ProfileEditDialog(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 12.0, left: 12),
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text(
                        "Do you want to save changes?",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: new Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: new TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              labelText: text,
                            ),
                          )),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text("No"),
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Yes"),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Networks.updateUser(
                                  context, "179", text, _textController.text);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
