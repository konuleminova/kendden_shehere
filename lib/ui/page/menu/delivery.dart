import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class DeliveryPage extends StatelessWidget {
  String title;

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = "assets/delivery_terms_az.txt";
    } else if (langCode == "en") {
      title = "assets/delivery_terms.txt";
    } else if (langCode == "ru") {
      title = "assets/delivery_terms_ru.txt";
    }
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text("Delivery Terms"),
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
          child: new Container(
            margin: EdgeInsets.all(16),
            child: new FutureBuilder(
                future: getFileData(title),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return new Text(snapshot.data,
                          style: new TextStyle(fontSize: 17));
                    }
                  } else {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ));
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}
