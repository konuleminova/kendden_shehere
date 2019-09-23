import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';

class ContactsPage extends StatelessWidget {
  String lang;

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
    }

    // TODO: implement build
    return new FutureBuilder(
        future: Networks.contacts(lang),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // ListInfo information = snapshot.data;
            if (snapshot.data != null) {
              String header = snapshot.data['header'] ?? "";
              String body = snapshot.data['body'] ?? "";
              return new Scaffold(
                  appBar: new AppBar(
                    title: Text(header),
                    backgroundColor: Colors.lightGreen,
                  ),
                  body: SingleChildScrollView(
                    child: new Container(
                      margin: EdgeInsets.all(16),
                      child: new Text(body, style: new TextStyle(fontSize: 17)),
                    ),
                  ));
            }
          } else {
            return Scaffold(
              body: Center(
                child: new CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
