import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/application.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  String _value = "en";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: new Text("Settings"),
        ),
        body: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Stack(
            children: <Widget>[
              Positioned(
                child: new Container(
                    child: new Text(
                      "Select Language",
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    margin: EdgeInsets.only(left: 16, right: 16, top: 16)),
                top: 5,
              ),
              Positioned(
                child: new Container(
                  child: _buildDropDown(),
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.only(left: 8),
                  width: 200,
                ),
                top: 45,
              ),
              new Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () async {
                        await application.onLocaleChanged(Locale(_value));
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }

  _buildDropDown() {
    DropdownButton _itemDown() => DropdownButton<String>(
          items: [
            DropdownMenuItem(
              value: "en",
              child: Row(
                children: <Widget>[
                  Text(
                    "English",
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "ru",
              child: Row(
                children: <Widget>[
                  Text(
                    "Russian",
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "tr",
              child: Row(
                children: <Widget>[
                  Text(
                    "Azerbaijani",
                  ),
                ],
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          value: _value,
          isExpanded: true,
        );
    return _itemDown();
  }
}
