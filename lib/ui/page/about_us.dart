import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text("About Us"),
          backgroundColor: Colors.lightGreen,
        ),
        body: new Container(
          margin: EdgeInsets.all(16),
          child: new FutureBuilder(
              future: getFileData('images/desc.txt'),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return new Text(snapshot.data);
                  }
                } else {
                  return new CircularProgressIndicator();
                }
              }),
        ));
  }


  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}
