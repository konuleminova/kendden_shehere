import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/widgets/dialog/dialog.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  final image = 'assets/img/2.jpg';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ProfileState();
  }
}

class ProfileState extends State<ProfilePage> {
  File cameraFile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("View Profile"),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 210,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                    colors: [Colors.lightGreen, Colors.lightGreen.shade300])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                        child: CircleAvatar(
                            minRadius: 60,
                            backgroundColor: Colors.green.shade300,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: cameraFile == null
                                  ? NetworkImage(
                                      'https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg')
                                  : new FileImage(cameraFile),
                              backgroundColor: Colors.transparent,
                            )),
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          print("selected");
                          imageSelectorCamera();
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Konul Eminova",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "200 Bonus",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                )
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("User information"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Usermame"),
                    subtitle: Text("konul"),
                    leading: Icon(Icons.verified_user),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (buildContext) {
                            return BeautifulAlertDialog("Username");
                          });
                    },
                  ),
                  ListTile(
                    title: Text("Email"),
                    subtitle: Text("keminova@gmail.com"),
                    leading: Icon(Icons.email),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (buildContext) {
                            return BeautifulAlertDialog("Email");
                          });
                    },
                  ),
                  ListTile(
                    title: Text("Phone"),
                    subtitle: Text("+944-9815225566"),
                    leading: Icon(Icons.phone),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (buildContext) {
                            return BeautifulAlertDialog("Phone");
                          });
                    },
                  ),
                  ListTile(
                    title: Text("Birthday"),
                    subtitle: Text("11.11.2011"),
                    leading: Icon(Icons.date_range),
                  ),
                  ListTile(
                    title: Text("Gender"),
                    subtitle: Text("Female"),
                    leading: Icon(Icons.person),
                  ),
                ],
              )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //  '/login', (Route<dynamic> route) => false);
                SharedPrefUtil().setUserHasLogin(false);
                // Navigator.pushNamed(context, "/login");
                //  Navigator.of(context).popUntil(ModalRoute.withName('/login'));
                // Navigator.pushNamed(context, "/");
                Navigator.pop<bool>(context, true);
              },
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  //display image selected from camera
  imageSelectorCamera() async {
    cameraFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      //maxHeight: 50.0,
      //maxWidth: 50.0,
    );
    print("You selected camera image : " + cameraFile.path);
    setState(() {});
  }
}
