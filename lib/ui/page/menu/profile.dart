import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final image = 'assets/img/2.jpg';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ProfileState();
  }
}

enum SingingCharacter { lafayette, jefferson }

class ProfileState extends State<ProfilePage> {
  File imageFile;
  UserModel userModel;

  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate = new DateTime.now();
  String currentMonth;
  bool isExpanded = false;
  String displayMonth;

  String gender = 'Female';

  DateTime get selectedDate => _selectedDate;

  @override
  void initState() {
    super.initState();
    userModel = new UserModel();
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1920),
      lastDate: new DateTime(2040),
    );

    if (selected != null) {
      setState(() {
        _selectedDate = selected;
//        selectedWeeksDays =
//            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//                .toList();
//        selectedMonthsDays = Utils.daysInMonth(selected);
//        displayMonth = Utils.formatMonth(selected);
      });
//      Networks().updateUser(
//        context,
//        'dob',
//        _selectedDate.year.toString() +
//            " /" +
//            _selectedDate.month.toString() +
//            " /" +
//            _selectedDate.day.toString(),
//      );
      // updating selected date range based on selected week
//      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
//      _launchDateSelectionCallback(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("View Profile"),
          backgroundColor: Colors.lightGreen,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: Networks().userinfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [
                                0.5,
                                0.9
                              ],
                              colors: [
                                Colors.lightGreen,
                                Colors.lightGreen.shade300
                              ])),
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
                                        backgroundImage: imageFile == null
                                            ? AssetImage('images/profile.png')
                                            : new FileImage(imageFile),
                                        backgroundColor: Colors.transparent,
                                      )),
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    print("selected");
                                    //imageSelectorCamera();
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
                                                              "Profile Photo",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .pink,
                                                                  fontSize: 18),
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
                                                            leading: new Icon(
                                                                Icons.camera),
                                                            title: Text(
                                                              "Camera",
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
                                                              "Gallery",
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data[1]['name'] +
                                " " +
                                snapshot.data[1]['surname'],
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
////                            ListTile(
////                              title: Text("User information"),
////                            ),
//                            Divider(),
                            ListTile(
                              title: Text("Name"),
                              subtitle: Text(snapshot.data[1]['name']),
                              leading: Icon(Icons.verified_user),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      return ProfileEditDialog("name");
                                    });
                              },
                            ),
                            ListTile(
                              title: Text("Surname"),
                              subtitle: Text(snapshot.data[1]['surname']),
                              leading: Icon(Icons.person),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      return ProfileEditDialog("surname");
                                    });
                              },
                            ),
                            ListTile(
                              title: Text("Mobile"),
                              subtitle: Text(snapshot.data[1]['mobile']),
                              leading: Icon(Icons.phone),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      return ProfileEditDialog("mobile");
                                    });
                              },
                            ),
//                            ListTile(
//                              title: Text("Email"),
//                              leading: Icon(Icons.person_outline),
//                              subtitle: Text(snapshot.data[1]['email']),
//                              onTap: () {
//                                showDialog(
//                                    context: context,
//                                    builder: (buildContext) {
//                                      return ProfileEditDialog("email");
//                                    });
//                              },
//                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text("Date of birth",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                          margin: EdgeInsets.only(
                                              left: 20, bottom: 8.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          height: 40,
                                          child: Row(
                                            children: <Widget>[
                                              Text(gender),
                                              PopupMenuButton<String>(
                                                onSelected: choiceAction,
                                                icon:
                                                Icon(Icons.arrow_drop_down),
                                                itemBuilder:
                                                    (BuildContext context) {
                                                  return Constants.gender
                                                      .map((String choice) {
                                                    return PopupMenuItem<
                                                        String>(
                                                      value: choice,
                                                      child: Text(choice),
                                                    );
                                                  }).toList();
                                                },
                                              )
                                            ],
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[400])),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Gender",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                margin: EdgeInsets.only(
                                                    left: 16, bottom: 8.0),
                                              ),
                                              Container(
                                                height: 40,
                                                margin:
                                                EdgeInsets.only(right: 16),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    Text(
                                                      _selectedDate.year
                                                          .toString() +
                                                          " /" +
                                                          _selectedDate.month
                                                              .toString() +
                                                          " /" +
                                                          _selectedDate.day
                                                              .toString(),
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                    ),
                                                    Icon(Icons.arrow_drop_down)
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                        Colors.grey[400])),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            selectDateFromPicker();
                                          },
                                        )))
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 16,),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //  '/login', (Route<dynamic> route) => false);
                          SharedPrefUtil()
                              .setBool(SharedPrefUtil().isLoginKey, false);
                          SharedPreferences.getInstance().then((onvalue) {
                            onvalue.clear();
                          });
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
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
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
    setState(() {});
  }

//  _getUserInfo() async {
//    userModel.name = await SharedPrefUtil().getString(SharedPrefUtil().name);
//    userModel.surname =
//        await SharedPrefUtil().getString(SharedPrefUtil().surname);
//    userModel.username =
//        await SharedPrefUtil().getString(SharedPrefUtil().username);
//    userModel.mobile = await SharedPrefUtil().getString(SharedPrefUtil().mobile);
//    return userModel;
//  }

  void choiceAction(String choice) {
    setState(() {
      gender = choice;
    });
  }
}
