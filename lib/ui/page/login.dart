import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/login_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kendden_shehere/util/instagram.dart' as insta;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController _controllerUsername, _controllerPass;
  FocusNode userFocus, passFocus;
  bool _validateUsername = false;
  bool _validatePassword = false;
  double opacity;
  bool status = false;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> facebookLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken}');
        final profile = json.decode(graphResponse.body);
        print("Profile:::");
        print(profile);
        _showMessage('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

//constants.APP_ID,
//constants.APP_SECRET
  void instagram_login() {
    insta
        .getToken('3164283233644276', '8c1ae9b878bfd2a582cfece9def0646d')
        .then((token) {
      if (token != null) {
        _showMessage("Login Success");
      } else {
        _showMessage("Login Error");
      }
    });
  }

  _showMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: StoreConnector(
        converter: (Store<AppState> store) => ViewModel.create(store),
        onInit: (store) {
          _controllerUsername.text = store.state.user_info.username;
          _controllerPass.text = store.state.user_info.password;
          if (store.state.user_info.username != null ||
              store.state.user_info.password != null) {
            opacity = 1;
            _validateUsername = true;
            _validatePassword = true;
          }
          store.onChange.listen((state) {
            if (state.user_info.status == STATUS.FAIL ||
                state.user_info.status == STATUS.NETWORK_ERROR ||
                state.user_info.status == STATUS.SUCCESS) {
              status = false;
            }
          });
        },
        builder: (BuildContext context, ViewModel viewModel) => Scaffold(
            // key: scaffoldKey,
            body: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(color: greyFixed),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('images/ks/logo.png'),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        child: Text(
                          AppTranslations.of(context).text('welcome'),
                          style: TextStyle(
                              color: greenFixed,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Text(
                          AppTranslations.of(context).text('sign_in_continue'),
                          style: TextStyle(color: blackFixed, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                          margin: EdgeInsets.all(16.0),
                          elevation: 4,
                          //padding: EdgeInsets.only(left: 4.0),
                          color: Colors.white,
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.green,
                                primaryColor: Colors.green,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: TextField(
                                  onSubmitted: (value) {
                                    //_controllerUsername.text=value;
                                    userFocus.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(passFocus);
                                  },
                                  onChanged: (value) {
                                    passFocus.unfocus();
                                    setState(() {
                                      _controllerUsername.text.isEmpty
                                          ? _validateUsername = false
                                          : _validateUsername = true;
                                      if (_validateUsername &&
                                          _validatePassword) {
                                        opacity = 1;
                                      } else {
                                        opacity = 0.5;
                                      }
                                    });
                                  },
                                  controller: _controllerUsername,
                                  textInputAction: TextInputAction.next,
                                  focusNode: userFocus,
                                  decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greenFixed)),
                                      hintText: AppTranslations.of(context)
                                          .text('enter_username'),
                                      labelText: AppTranslations.of(context)
                                          .text('username'),
                                      hintStyle: TextStyle(color: greenFixed),
                                      labelStyle: new TextStyle(
                                          color: const Color(0xFF424242)),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greenFixed))),
                                ),
                              )
                              // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                              )),
//                    Container(child:   Padding(
//                      padding: const EdgeInsets.all(16.0),
//                      child: TextField(
//                        decoration: InputDecoration(
//                          border: OutlineInputBorder(borderSide: BorderSide.none),
//                          labelText: 'Username',
//                        ),
//                      ),
//                    ),height: 56,color: Colors.white,),
                      Card(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          elevation: 4,
                          // padding: EdgeInsets.only(left: 4.0),
                          color: Colors.white,
                          child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.green,
                                primaryColor: Colors.green,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: new TextField(
                                  onSubmitted: (value) {
                                    //_controllerPass.text=value;
                                    passFocus.unfocus();
                                    userFocus.unfocus();
                                    if (_validateUsername &&
                                        _validatePassword) {
                                      viewModel.buildLogin(
                                          _controllerUsername.text,
                                          _controllerPass.text);
                                      setState(() {
                                        status = true;
                                      });
                                    }
                                  },
                                  onChanged: (value) {
                                    userFocus.unfocus();
                                    setState(() {
                                      _controllerPass.text.isEmpty
                                          ? _validatePassword = false
                                          : _validatePassword = true;
                                      if (_validateUsername &&
                                          _validatePassword) {
                                        opacity = 1;
                                      } else {
                                        opacity = 0.5;
                                      }
                                    });
                                  },
                                  autofocus: false,
                                  obscureText: true,
                                  controller: _controllerPass,
                                  textInputAction: TextInputAction.done,
                                  focusNode: passFocus,
                                  decoration: new InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greenFixed)),
                                      hintText: AppTranslations.of(context)
                                          .text('enter_pass'),
                                      labelText: AppTranslations.of(context)
                                          .text('password'),
                                      hintStyle: TextStyle(color: greenFixed),
                                      labelStyle: new TextStyle(
                                          color: const Color(0xFF424242)),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greenFixed))),
                                ),
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 20,top: 8,bottom: 8),
                        child: Text(
                          "error",
                          style: TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Opacity(
                        opacity: opacity,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(30.0),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            color: greenFixed,
                            onPressed: () {
                              passFocus.unfocus();
                              userFocus.unfocus();
                              if (_validateUsername && _validatePassword) {
                                viewModel.buildLogin(_controllerUsername.text,
                                    _controllerPass.text);
                                setState(() {
                                  status = true;
                                });
                              }
                            },
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: _showProgress(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                child: CircleAvatar(
                                    backgroundColor: greyFixed,
                                    child: Image.asset(
                                      'images/ks/facebook.png',
                                      fit: BoxFit.fill,
                                    )),
                                onTap: () {
                                  facebookLogin();
                                },
                              ),
                            ),
                            Expanded(
                                child: CircleAvatar(
                                    backgroundColor: greyFixed,
                                    child: Image.asset(
                                      'images/ks/google.png',
                                    ))),
                            Text(AppTranslations.of(context).text('or')),
                            Expanded(
                                child: GestureDetector(
                              child: CircleAvatar(
                                  backgroundColor: greyFixed,
                                  child:
                                      Image.asset('images/ks/instagram.png')),
                              onTap: () {
                                instagram_login();
                              },
                            )),
                          ],
                        ),
                        width: 180,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(AppTranslations.of(context).text('sign_up_for')),
//                          FlatButton(
//                            child: Text(
//                                AppTranslations.of(context).text('sign_up')),
//                            textColor: Colors.indigo,
//                            onPressed: () {
//                              return Navigator.pushNamed(context, "/register");
//                            },
//                          )
                      ],
                    ),
                    alignment: AlignmentDirectional.bottomEnd,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
            ),
          ),
        )),
      ),
      onWillPop: () {
        SystemNavigator.pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    opacity = 0.5;
    _controllerUsername = TextEditingController();
    _controllerPass = TextEditingController();
    userFocus = new FocusNode();
    passFocus = new FocusNode();
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  _showProgress() {
    if (!status) {
      return Text(AppTranslations.of(context).text('login'),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
