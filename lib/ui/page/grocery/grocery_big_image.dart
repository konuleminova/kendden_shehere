import 'package:flutter/material.dart';

class GroceryBigImage extends StatelessWidget {
  String code;

  GroceryBigImage({this.code});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
     backgroundColor: Colors.black87,
      body: FutureBuilder(
          future: getImage(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(child: new Container(
              child: Image.network(snapshot.data),
            ),);
            } else {
              return Center(child: new  CircularProgressIndicator(),);
            }
          })
    );
  }

  Future<String> getImage() async {
    String img = await "https://kenddenshehere.az/images/pr/" + code + ".jpg";
    return img;
  }
}
