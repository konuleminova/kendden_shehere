import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class FagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text("FAG"),
          backgroundColor: Colors.lightGreen,
        ),
        body: SingleChildScrollView(
          child: new Container(
            margin: EdgeInsets.all(16),
            child: new FutureBuilder(
                future: getFileData('images/fag.txt'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return new Text(
                        snapshot.data,
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      );
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
