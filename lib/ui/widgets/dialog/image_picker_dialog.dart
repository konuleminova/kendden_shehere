import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/page/menu/profile.dart';

class ImagePickerDialog extends StatefulWidget {
  File cameraFile;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImagePickerState();
  }

  getFile() {
    return cameraFile;
  }
}

class ImagePickerState extends State<ImagePickerDialog> {
  static File cameraFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                        AppTranslations.of(context).text('profile_photo'),
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
                        AppTranslations.of(context).text('camera'),
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        imageSelectorCamera(context, ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text(
                        AppTranslations.of(context).text('gallery'),
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
    setState(() {
      widget.cameraFile = cameraFile;
      Navigator.pop(context);
      ProfilePage page=new ProfilePage();
      //page.getFile(cameraFile);
    });
  }
}
