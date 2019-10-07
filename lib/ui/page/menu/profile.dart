import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/dialog/image_picker_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/ui/widgets/gender.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kendden_shehere/util/util.dart';

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
  SingingCharacter _character = SingingCharacter.lafayette;
  bool _isRadioSelected = false;

  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate = new DateTime.now();
  String currentMonth;
  bool isExpanded = false;
  String displayMonth;

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
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays =
            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList();
        selectedMonthsDays = Utils.daysInMonth(selected);
        displayMonth = Utils.formatMonth(selected);
      });
      // updating selected date range based on selected week
//      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
//      _launchDateSelectionCallback(selected);
    }
  }

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
        body: FutureBuilder(
            future: Networks.userinfo(),
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
                                            ? NetworkImage(
                                                'https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg')
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
                            ListTile(
                              title: Text("Email"),
                              leading: Icon(Icons.person_outline),
                              subtitle: Text(snapshot.data[1]['email']),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (buildContext) {
                                      return ProfileEditDialog("email");
                                    });
                              },
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <LabeledRadio>[
                                      LabeledRadio(
                                        label: 'Female',
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        value: true,
                                        groupValue: _isRadioSelected,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            _isRadioSelected = newValue;
                                          });
                                        },
                                      ),
                                      LabeledRadio(
                                        label: 'Male',
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        value: false,
                                        groupValue: _isRadioSelected,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            _isRadioSelected = newValue;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(child: Container(

                                          height: 40,
                                          margin: EdgeInsets.only(right: 16),
                                          alignment: Alignment.center,
                                          child: Text(_selectedDate.year.toString() +
                                                " /" +
                                                _selectedDate.month.toString() +
                                                " /" +
                                                _selectedDate.day.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              border: Border.all(
                                                  color: Colors.white)),
                                        ),onTap: (){
                                          selectDateFromPicker();
                                        },)))
                              ],
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
                          SharedPrefUtil()
                              .setBool(SharedPrefUtil.isLoginKey, false);
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
    Navigator.pop(context);
    setState(() {});
    print("You selected camera image : " + imageFile.path);
  }

//  _getUserInfo() async {
//    userModel.name = await SharedPrefUtil().getString(SharedPrefUtil.name);
//    userModel.surname =
//        await SharedPrefUtil().getString(SharedPrefUtil.surname);
//    userModel.username =
//        await SharedPrefUtil().getString(SharedPrefUtil.username);
//    userModel.mobile = await SharedPrefUtil().getString(SharedPrefUtil.mobile);
//    return userModel;
//  }
}
