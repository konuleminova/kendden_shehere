import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class DeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                future: getFileData('images/delivery_terms.txt'),
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
