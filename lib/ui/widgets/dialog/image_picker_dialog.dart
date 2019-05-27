import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kendden_shehere/ui/page/menu/profile.dart';

class ImagePickerDialog extends StatelessWidget {
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 12.0, left: 12),
          height: 190,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        "Profile Photo",
                        style: TextStyle(color: Colors.pink, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),

                    //SizedBox(height: 5.0),
                    ListTile(
                      leading: new Icon(Icons.camera),
                      title: Text(
                        "Camera",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        imageSelectorCamera(context, ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text(
                        "Gallery",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        imageSelectorCamera(context, ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //display image selected from camera
  imageSelectorCamera(BuildContext context, ImageSource imageSource) async {
    cameraFile = await ImagePicker.pickImage(source: imageSource
        //maxHeight: 50.0,
        //maxWidth: 50.0,
        );
    if (cameraFile != null) {
      Route route = MaterialPageRoute(
          builder: (context) => ProfilePage(
                file: cameraFile,
              ));
      Navigator.push(context, route);
    }
    print("You selected camera image : " + cameraFile.path);
    // setState(() {});
  }
}
