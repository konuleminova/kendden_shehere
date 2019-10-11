import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
//import 'package:zoomable_image/zoomable_image.dart';

class GroceryBigImage extends StatelessWidget {
  String code;
  GroceryBigImage({this.code});

  @override
  Widget build(BuildContext context) {
    String img = "https://kenddenshehere.az/images/pr/" + code + ".jpg";
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
            child: new Container(
                child: PhotoView(imageProvider: NetworkImage(img)))));
  }
}