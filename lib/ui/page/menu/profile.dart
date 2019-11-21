import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

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
  String gender;
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerSurname = new TextEditingController();
  TextEditingController _controllerDob = new TextEditingController();
  TextEditingController _controllerMobile = new TextEditingController();
  TextEditingController _controllerAddress = new TextEditingController();

  DateTime get selectedDate => _selectedDate;
  bool _enabled = false;
  Future _future;

  @override
  void initState() {
    super.initState();

    userModel = new UserModel();
   _future= Networks().userinfo();
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
        print(_selectedDate);

        _controllerDob.text = _selectedDate.year.toString() +
            " /" +
            _selectedDate.month.toString() +
            " /" +
            _selectedDate.day.toString();
        _selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    gender = AppTranslations.of(context).text('female');
    // TODO: implement build
    return Scaffold(
        backgroundColor: greyFixed,
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text('view_profile')),
          backgroundColor: greenFixed,
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              child: Image.asset(
                'images/ks/writing.png',
              ),
              onTap: () {
                setState(() {
                  _enabled = true;
                });
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final UriData data = Uri.parse(snapshot.data[1]['img']).data;
                _controllerName.text = snapshot.data[1]['name'];
                _controllerSurname.text = snapshot.data[1]['surname'];
           if(!_enabled){
             _controllerDob.text = snapshot.data[1]['dob'];
           }
                String mobile = snapshot.data[1]['mobile'];
                _controllerMobile.text = mobile.substring(4);
                _controllerAddress.text = snapshot.data[1]['adress'];
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
                                            _enabled
                                                ? Align(
                                                    child: Image.asset(
                                                      'images/ks/upload.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    alignment: Alignment.center,
                                                  )
                                                : SizedBox()
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
                        decoration: BoxDecoration(
                          color: greyFixed,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: <Widget>[
//                            ListTile(
//                              title: Text(
//                                AppTranslations.of(context).text('name'),
//                              ),
//                              subtitle: Text(snapshot.data[1]['name']),
//                              leading: Icon(Icons.verified_user),
//                              onTap: () {
//                                showDialog(
//                                    context: context,
//                                    builder: (buildContext) {
//                                      return ProfileEditDialog("name");
//                                    });
//                              },
//                            ),
                            Card(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                elevation: 2,
                                //  padding: EdgeInsets.only(left: 4.0),
                                color: Colors.white,
                                child: new Theme(
                                    data: new ThemeData(
                                      hintColor: Colors.green,
                                      primaryColor: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        enabled: _enabled,
                                        controller: _controllerName,
                                        decoration: new InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greenFixed)),
                                            hintText: "Enter your name",
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text('name'),
                                            hintStyle:
                                                TextStyle(color: greenFixed),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: greenFixed))),
                                      ),
                                    )
                                    // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                                    )),
                            Card(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                elevation: 2,
                                //  padding: EdgeInsets.only(left: 4.0),
                                color: Colors.white,
                                child: new Theme(
                                    data: new ThemeData(
                                      hintColor: Colors.green,
                                      primaryColor: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: _controllerSurname,
                                        enabled: _enabled,
                                        decoration: new InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greenFixed)),
                                            hintText: "Enter your surname",
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text('surname'),
                                            hintStyle:
                                                TextStyle(color: greenFixed),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: greenFixed))),
                                      ),
                                    )
                                    // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                                    )),
                            Card(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                elevation: 2,
                                //  padding: EdgeInsets.only(left: 4.0),
                                color: Colors.white,
                                child: new Theme(
                                    data: new ThemeData(
                                      hintColor: Colors.green,
                                      primaryColor: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: _controllerDob,
                                        enabled: _enabled,
                                        decoration: new InputDecoration(
                                            suffixIcon: _enabled
                                                ? GestureDetector(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'images/ks/calendar.png'),
                                                    ),
                                                    onTap: () {
                                                      print("Calendar");
                                                      selectDateFromPicker();
                                                    },
                                                  )
                                                : SizedBox(),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greenFixed)),
                                            hintText: "Enter your birthday",
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text('dob'),
                                            hintStyle:
                                                TextStyle(color: greenFixed),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: greenFixed))),
                                      ),
                                    )
                                    // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                                    )),
                            Card(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                elevation: 2,
                                //  padding: EdgeInsets.only(left: 4.0),
                                color: Colors.white,
                                child: new Theme(
                                    data: new ThemeData(
                                      hintColor: Colors.green,
                                      primaryColor: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: _controllerMobile,
                                        enabled: _enabled,
                                        decoration: new InputDecoration(
                                            icon: Text(
                                              "+994",
                                              style: TextStyle(
                                                  color: blackFixed,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greenFixed)),
                                            hintText: "Enter your phone number",
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text('mobile'),
                                            hintStyle:
                                                TextStyle(color: greenFixed),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: greenFixed))),
                                      ),
                                    )
                                    // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                                    )),
                            Card(
                                margin: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 12),
                                elevation: 2,
                                //  padding: EdgeInsets.only(left: 4.0),
                                color: Colors.white,
                                child: new Theme(
                                    data: new ThemeData(
                                      hintColor: Colors.green,
                                      primaryColor: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: _controllerAddress,
                                        enabled: _enabled,
                                        decoration: new InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: greenFixed)),
                                            hintText: "Enter your address",
                                            labelText:
                                                AppTranslations.of(context)
                                                    .text('address'),
                                            hintStyle:
                                                TextStyle(color: greenFixed),
                                            labelStyle: new TextStyle(
                                                color: const Color(0xFF424242)),
                                            border: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: greenFixed))),
                                      ),
                                    )
                                    // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                                    )),
                          ],
                        )),
                    !_enabled
                        ? Container(
                            width: double.infinity,
                            child: ListTile(
                              title: Text(
                                AppTranslations.of(context).text('sign_out'),
                                style: TextStyle(fontSize: 18),
                              ),
                              onTap: () async {
                                // Navigator.of(context).pushNamedAndRemoveUntil(
                                //  '/login', (Route<dynamic> route) => false);
                                await SharedPrefUtil().setBool(
                                    SharedPrefUtil().isLoginKey, false);
                                SharedPreferences.getInstance().then((onvalue) {
                                  onvalue.clear();
                                });
                                Navigator.pushReplacementNamed(
                                    context, "/login");
                                // Navigator.of(context).popUntil(ModalRoute.withName('/login'));
                                // Navigator.pushNamed(context, "/");
                                //Navigator.pop<bool>(context, true);
                              },
                            ))
                        : SizedBox(),
                    _enabled
                        ? Align(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30.0),
                              child: RaisedButton(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  color: greenFixed,
                                  disabledColor: greenFixed,
                                  onPressed: null,
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
                        : SizedBox()
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

  void choiceAction(String choice) {
    setState(() {
      gender = choice;
    });
  }
}

//                            Row(
//                              children: <Widget>[
//                                Expanded(
//                                    flex: 2,
//                                    child: Column(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.start,
//                                      crossAxisAlignment:
//                                          CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Container(
//                                          child: Text(
//                                              AppTranslations.of(context)
//                                                  .text('dob'),
//                                              style: TextStyle(
//                                                  color: Colors.grey)),
//                                          margin: EdgeInsets.only(
//                                              left: 20, bottom: 8.0),
//                                        ),
//                                        Container(
//                                          margin: EdgeInsets.only(left: 20),
//                                          height: 40,
//                                          child: Row(
//                                            children: <Widget>[
//                                              Text(gender),
//                                              PopupMenuButton<String>(
//                                                onSelected: choiceAction,
//                                                icon:
//                                                    Icon(Icons.arrow_drop_down),
//                                                itemBuilder:
//                                                    (BuildContext context) {
//                                                  return Constants.gender
//                                                      .map((String choice) {
//                                                    return PopupMenuItem<
//                                                        String>(
//                                                      value: choice,
//                                                      child: Text(choice),
//                                                    );
//                                                  }).toList();
//                                                },
//                                              )
//                                            ],
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.center,
//                                          ),
//                                          decoration: BoxDecoration(
//                                              border: Border.all(
//                                                  color: Colors.grey[400])),
//                                        )
//                                      ],
//                                    )),
//                                SizedBox(
//                                  width: 16.0,
//                                ),
//                                Expanded(
//                                    flex: 3,
//                                    child: Align(
//                                        alignment: Alignment.centerRight,
//                                        child: GestureDetector(
//                                          child: Column(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.start,
//                                            crossAxisAlignment:
//                                                CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              Container(
//                                                child: Text(
//                                                  "Gender",
//                                                  style: TextStyle(
//                                                      color: Colors.grey),
//                                                ),
//                                                margin: EdgeInsets.only(
//                                                    left: 16, bottom: 8.0),
//                                              ),
//                                              Container(
//                                                height: 40,
//                                                margin:
//                                                    EdgeInsets.only(right: 16),
//                                                alignment: Alignment.center,
//                                                child: Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment
//                                                          .spaceAround,
//                                                  children: <Widget>[
//                                                    SizedBox(
//                                                      width: 8.0,
//                                                    ),
//                                                    Text(
//                                                      _selectedDate.year
//                                                              .toString() +
//                                                          " /" +
//                                                          _selectedDate.month
//                                                              .toString() +
//                                                          " /" +
//                                                          _selectedDate.day
//                                                              .toString(),
//                                                      textAlign:
//                                                          TextAlign.center,
//                                                      style: TextStyle(
//                                                          color: Colors.black,
//                                                          fontSize: 16),
//                                                    ),
//                                                    Icon(Icons.arrow_drop_down)
//                                                  ],
//                                                ),
//                                                decoration: BoxDecoration(
//                                                    border: Border.all(
//                                                        color:
//                                                            Colors.grey[400])),
//                                              ),
//                                            ],
//                                          ),
//                                          onTap: () {
//                                            selectDateFromPicker();
//                                          },
//                                        )))
//                              ],
//                            ),
