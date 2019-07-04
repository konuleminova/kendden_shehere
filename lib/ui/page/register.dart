import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/login_viewmodel.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/register/register_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:redux/redux.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  bool status;
  RegisterViewModel viewModel;
  bool _validateUsername = false;
  bool _validateName = false;
  bool _validateSurname = false;
  bool _validateMobile = false;
  bool _validatePassword = false;
  bool _validatePass2 = false;
  TextEditingController _controllerUsername, _controllerPass, _controllerPass2;
  TextEditingController _controllerName, _controllerSurname;
  TextEditingController _controllerMobile;
  FocusNode userFocus, passFocus;
  FocusNode nameFocus, pass2Focus;
  FocusNode surnameFocus, mobileFocus;
  double opacity;
  String lang;

  @override
  void initState() {
    super.initState();
    opacity = 0.5;
    _controllerUsername = TextEditingController();
    _controllerPass = TextEditingController();
    _controllerName = TextEditingController();
    _controllerSurname = TextEditingController();
    _controllerMobile = TextEditingController();
    _controllerPass2 = TextEditingController();
    userFocus = new FocusNode();
    passFocus = new FocusNode();
    pass2Focus = new FocusNode();
    nameFocus = new FocusNode();
    surnameFocus = new FocusNode();
    mobileFocus = new FocusNode();
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPass.dispose();
    _controllerPass2.dispose();
    _controllerName.dispose();
    _controllerSurname.dispose();
    _controllerMobile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en")
    {
      lang = "2";
    } else if (langCode == "ru") {
      lang="1";
    }
    // TODO: implement build
    return StoreConnector(
        converter: (Store<AppState> store) => RegisterViewModel.create(store),
        onInit: (store) {
          store.onChange.listen((state) {
            if (state.user_info.status == STATUS.FAIL ||
                state.user_info.status == STATUS.NETWORK_ERROR ||
                state.user_info.status == STATUS.SUCCESS) {
              status = false;
              print(state.user_info.status);
            }
          });
        },
        builder: (BuildContext context, RegisterViewModel viewModel) {
          this.viewModel = viewModel;
          return Scaffold(
            key: scaffoldRegisterKey,
            body: Stack(
              children: <Widget>[
                Container(
                  color: Colors.lightGreen,
                  child: ListView(
                    children: <Widget>[
                      new Container(
                        child: Text("Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0)),
                        margin: EdgeInsets.only(top: 16),
                      ),
                      _buildLoginForm(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Do you have an account?"),
                                FlatButton(
                                  child: Text("Sign in"),
                                  textColor: Colors.indigo,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        focusNode: userFocus,
                        controller: _controllerUsername,
                        onChanged: (value) {
                          passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validateUsername = false
                                : _validateUsername = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        onSubmitted: (value) {
                          //_controllerUsername.text=value;
                          userFocus.unfocus();
                          FocusScope.of(context).requestFocus(nameFocus);
                        },
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.verified_user,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        focusNode: nameFocus,
                        controller: _controllerName,
                        onChanged: (value) {
                          passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validateName = false
                                : _validateName = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        onSubmitted: (value) {
                          //_controllerUsername.text=value;
                          nameFocus.unfocus();
                          FocusScope.of(context).requestFocus(surnameFocus);
                        },
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        focusNode: surnameFocus,
                        controller: _controllerSurname,
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validateSurname = false
                                : _validateSurname = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        onSubmitted: (value) {
                          //_controllerUsername.text=value;
                          surnameFocus.unfocus();
                          FocusScope.of(context).requestFocus(mobileFocus);
                        },
                        decoration: InputDecoration(
                            hintText: "Surname",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        focusNode: mobileFocus,
                        controller: _controllerMobile,
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validateMobile = false
                                : _validateMobile = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        onSubmitted: (value) {
                          //_controllerUsername.text=value;
                          mobileFocus.unfocus();
                          FocusScope.of(context).requestFocus(passFocus);
                        },
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.phone,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        focusNode: passFocus,
                        controller: _controllerPass,
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          //  passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validatePassword = false
                                : _validatePassword = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        onSubmitted: (value) {
                          //_controllerUsername.text=value;
                          passFocus.unfocus();
                          FocusScope.of(context).requestFocus(pass2Focus);
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _controllerPass2,
                        focusNode: pass2Focus,
                        style: TextStyle(color: Colors.blue),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          // passFocus.unfocus();
                          setState(() {
                            _controllerUsername.text.trim().isEmpty
                                ? _validatePass2 = false
                                : _validatePass2 = true;
                            if (_validateUsername &&
                                _validatePassword &&
                                _validateName &&
                                _validateSurname &&
                                _validateMobile & _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Confirm password",
                            hintStyle: TextStyle(color: Colors.blue.shade200),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: Colors.blue.shade400,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: opacity,
            child: Container(
              height: 500,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                color: Colors.green[700],
                onPressed: () {
                  passFocus.unfocus();
                  userFocus.unfocus();
                  if (_validateUsername &&
                      _validatePassword &&
                      _validateMobile &&
                      _validateSurname &&
                      _validateName &&
                      _validatePass2) {
                      UserModel userModel = new UserModel();
                      userModel.name = _controllerName.text;
                      userModel.surname = _controllerSurname.text;
                      userModel.username =_controllerUsername.text;
                      userModel.password = _controllerPass.text;
                      viewModel.buildRegister(lang, userModel);

                    setState(() {
                      status = true;
                    });
                  }

                  // Networks.register("0", userModel);
                },
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              alignment: AlignmentDirectional.bottomCenter,
            ),
          )
        ],
      ),
    );
  }
}
