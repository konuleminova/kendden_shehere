import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class PassWordChange extends StatelessWidget {
  var imageFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: new Text(AppTranslations.of(context).text('change_pass')),
          backgroundColor: greenFixed,
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: Networks().userinfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final UriData data = Uri.parse(snapshot.data[1]['img']).data;
                return ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                color: greenFixed,
                              )),
                              Expanded(
                                child: Container(),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                    child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Colors.transparent,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            data != null && imageFile == null
                                                ? ClipOval(
                                                    child: new Image.memory(
                                                        data.contentAsBytes(),
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill),
                                                  )
                                                : CircleAvatar(
                                                    radius: 55.0,
                                                    backgroundImage:
                                                        imageFile == null
                                                            ? AssetImage(
                                                                'images/ks/profile.png',
                                                              )
                                                            : new FileImage(
                                                                imageFile),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                          ],
                                        )),
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (buildContext) {
                                            return Center(
                                              child: Dialog(
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0, left: 12),
                                                  height: 190,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                AppTranslations.of(
                                                                        context)
                                                                    .text(
                                                                        'profile_photo'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .pink,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.0,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.blue,
                                                            ),

                                                            //SizedBox(height: 5.0),
                                                            ListTile(
                                                              leading: new Icon(
                                                                  Icons.camera),
                                                              title: Text(
                                                                AppTranslations.of(
                                                                        context)
                                                                    .text(
                                                                        'camera'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              onTap: () {
                                                                imageSelector(
                                                                    context,
                                                                    ImageSource
                                                                        .camera);
                                                              },
                                                            ),
                                                            ListTile(
                                                              leading: Icon(
                                                                  Icons.image),
                                                              title: Text(
                                                                AppTranslations.of(
                                                                        context)
                                                                    .text(
                                                                        'gallery'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              onTap: () {
                                                                imageSelector(
                                                                    context,
                                                                    ImageSource
                                                                        .gallery);
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
                                          });
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Card(
                          margin:
                              EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          elevation: 2,
                          //  padding: EdgeInsets.only(left: 4.0),
                          color: Colors.white,
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.green,
                                primaryColor: Colors.green,
                                disabledColor: greenFixed,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  onChanged: (d) {},
                                  decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greenFixed)),
                                      hintText: AppTranslations.of(context)
                                          .text('enter_current_pass'),
                                      labelText: AppTranslations.of(context)
                                          .text('current_pass'),
                                      hintStyle: TextStyle(color: greenFixed),
                                      labelStyle:
                                          new TextStyle(color: Colors.grey),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greenFixed))),
                                ),
                              )
                              // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                              )),
                    ),
                    Card(
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        elevation: 2,
                        //  padding: EdgeInsets.only(left: 4.0),
                        color: Colors.white,
                        child: new Theme(
                            data: new ThemeData(
                              hintColor: Colors.green,
                              primaryColor: Colors.green,
                              disabledColor: greenFixed,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: TextField(
                                onChanged: (d) {},
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greenFixed)),
                                    hintText: AppTranslations.of(context)
                                        .text('enter_new_pass'),
                                    labelText: AppTranslations.of(context)
                                        .text('new_pass'),
                                    hintStyle: TextStyle(color: greenFixed),
                                    labelStyle:
                                        new TextStyle(color: Colors.grey),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: greenFixed))),
                              ),
                            )
                            // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                            )),
                    Card(
                        margin:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        elevation: 2,
                        //  padding: EdgeInsets.only(left: 4.0),
                        color: Colors.white,
                        child: new Theme(
                            data: new ThemeData(
                              hintColor: Colors.green,
                              primaryColor: Colors.green,
                              disabledColor: greenFixed,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: TextField(
                                onChanged: (d) {},
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: greenFixed)),
                                    hintText: AppTranslations.of(context)
                                        .text('enter_new_confirm_pass'),
                                    labelText: AppTranslations.of(context)
                                        .text('confirm_new_pass'),
                                    hintStyle: TextStyle(color: greenFixed),
                                    labelStyle:
                                        new TextStyle(color: Colors.grey),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: greenFixed))),
                              ),
                            )
                            // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                            )),
                    Align(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            color: greenFixed,
                            disabledColor: greenFixed,
                            onPressed: () {
                                Networks().updateUser(context, 'pass',"");
                            },
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0))),
                            child: Text(
                              AppTranslations.of(context).text('save'),
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      alignment: AlignmentDirectional(0, 0.5),
                    )
                  ],
                );
              } else {
                return loading();
              }
            }));
  }

  imageSelector(BuildContext context, ImageSource imageSource) async {
    imageFile = await ImagePicker.pickImage(source: imageSource
        //maxHeight: 50.0,
        //maxWidth: 50.0,
        );
    if (imageFile != null) {
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      print("base 64");
      print(base64Image);
      Networks().upload(base64Image);
    }
    Navigator.pop(context);
    // setState(() {});
  }
}
