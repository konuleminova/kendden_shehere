import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

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
          centerTitle: true,
          backgroundColor: greenFixed,
          title: new Text(AppTranslations.of(context).text('settings')),
        ),
        body: new Container(
          width: double.infinity,
          height: double.infinity,
          child: new Stack(
            children: <Widget>[
              Positioned(
                child: new Container(
                    child: new Text(
                      AppTranslations.of(context).text('select_lang'),
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
                  width: double.infinity,
                  padding: EdgeInsets.all(30.0),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      color: greenFixed,
                      disabledColor: greenFixed,
                      onPressed: () {
                        SharedPrefUtil()
                            .setString(SharedPrefUtil().lang, _value);
                        application.onLocaleChanged(Locale(_value, ""));
                        Navigator.pop(context);
                      },
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                      child: Text(
                        AppTranslations.of(context).text('save'),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
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
                    AppTranslations.of(context).text('english'),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "ru",
              child: Row(
                children: <Widget>[
                  Text(
                    AppTranslations.of(context).text('russian'),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: "tr",
              child: Row(
                children: <Widget>[
                  Text(
                    AppTranslations.of(context).text('az'),
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

  @override
  void initState() {
    super.initState();
    SharedPrefUtil().getString(SharedPrefUtil().lang).then((onvalue) {
      setState(() {
        if (onvalue == "") {
          _value = "en";
        } else {
          _value = onvalue;
        }
      });
    });
  }
}
