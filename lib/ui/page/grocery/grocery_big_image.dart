import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GroceryBigImage extends StatelessWidget {
  String code;

  GroceryBigImage({this.code});

  @override
  Widget build(BuildContext context) {
    String img = "https://kenddenshehere.az/images/pr/" + code + ".jpg";
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: <Widget>[
            Center(
                child: new Container(
                    child: PhotoView(imageProvider: NetworkImage(img)))),
            Positioned(
              top: 30.0,
              left: 16.0,
              child: CircleAvatar(child: IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),radius: 24,backgroundColor: Colors.grey,)
            )
          ],
        ));
  }
}
