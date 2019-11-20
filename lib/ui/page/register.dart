import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/register/register_viewmodel.dart';
import 'package:redux/redux.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  bool status = false;
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
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
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
            }
          });
        },
        builder: (BuildContext context, RegisterViewModel viewModel) {
          this.viewModel = viewModel;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: greyFixed,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: greenFixed,
                ),
              ),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: greenFixed),
                  ),
                )
              ],
            ),
            //  key: scaffoldRegisterKey,
            body: Stack(
              children: <Widget>[
                Container(
                  color: greyFixed,
                  child: ListView(
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
                                "Welcome to Kendden Shehere",
                                style: TextStyle(
                                    color: greenFixed,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      _buildLoginForm(),
                      Opacity(
                        opacity: opacity,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          margin: EdgeInsets.all(16.0),
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: RaisedButton(
//                            padding: EdgeInsets.symmetric(
//                                vertical: 16.0, horizontal: 16.0),
                            color: greenFixed,
                            onPressed: () {
                              passFocus.unfocus();
                              userFocus.unfocus();
                              pass2Focus.unfocus();
                              nameFocus.unfocus();
                              surnameFocus.unfocus();
                              mobileFocus.unfocus();
                              if (_validateUsername &&
                                  _validatePassword &&
                                  _validateMobile &&
                                  _validateSurname &&
                                  _validateName &&
                                  _validatePass2) {
                                UserModel userModel = new UserModel();
                                userModel.name = _controllerName.text;
                                userModel.surname = _controllerSurname.text;
                                userModel.username = _controllerUsername.text;
                                userModel.mobile = _controllerMobile.text;
                                userModel.password = _controllerPass.text;
                                userModel.password2 = _controllerPass2.text;
                                viewModel.buildRegister(lang, userModel);

                                setState(() {
                                  status = true;
                                });
                              }

                              // Networks().register("0", userModel);
                            },
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: !status
                                ? Text(
                                    AppTranslations.of(context).text('sign_up'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          //alignment: AlignmentDirectional.bottomCenter,
                        ),
                      ),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child:TextField(
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
                                  _validateMobile &&
                                  _validatePass2) {
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
                          style: TextStyle(color: blackFixed),
                          textInputAction: TextInputAction.next,
                          decoration: new InputDecoration(
                              hintText: "Enter your username",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: greenFixed)),
                              labelText:
                                  AppTranslations.of(context).text('username'),
                              hintStyle: TextStyle(color: greenFixed),
                              labelStyle:
                                  new TextStyle(color: const Color(0xFF424242)),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: greenFixed))),
                        ),
                      )))),
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child:Padding(
                          padding: EdgeInsets.only(left: 8),
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
                                _validateMobile &&
                                _validatePass2) {
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
                        style: TextStyle(color: blackFixed),
                        textInputAction: TextInputAction.next,
                        decoration: new InputDecoration(
                            hintText: "Enter your name",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: greenFixed)),
                            labelText: AppTranslations.of(context).text('name'),
                            hintStyle: TextStyle(color: greenFixed),
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242)),
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: greenFixed))),
                      )))),
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child:Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: TextField(
                        focusNode: surnameFocus,
                        controller: _controllerSurname,
                        style: TextStyle(color: blackFixed),
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
                                _validateMobile &&
                                _validatePass2) {
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
                        decoration: new InputDecoration(
                            hintText: "Enter your surname",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: greenFixed)),
                            labelText:
                                AppTranslations.of(context).text('surname'),
                            hintStyle: TextStyle(color: greenFixed),
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242)),
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: greenFixed))),
                      )))),
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child:Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: TextField(
                        focusNode: mobileFocus,
                        controller: _controllerMobile,
                        style: TextStyle(color: blackFixed),
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
                                _validateMobile &&
                                _validatePass2) {
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
                        keyboardType: TextInputType.phone,
                        maxLength: 9,
                        decoration: InputDecoration(
                            hintText:
                                AppTranslations.of(context).text('mobile'),
                            counterText: "",
                            hintStyle: TextStyle(color: greenFixed),
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: greenFixed)),
                            labelText: "Phone Number",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: greenFixed)),
                            icon: Text(
                              "+994",
                              style: TextStyle(
                                  color: blackFixed,
                                  fontWeight: FontWeight.bold),
                            )),
                      )))),
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextField(
                          focusNode: passFocus,
                          controller: _controllerPass,
                          style: TextStyle(color: blackFixed),
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
                                  _validateMobile &&
                                  _validatePass2) {
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
                          obscureText: true,
                          decoration: new InputDecoration(
                              hintText: "Enter your password",
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: greenFixed)),
                              labelText: "Password",
                              hintStyle: TextStyle(color: greenFixed),
                              labelStyle:
                                  new TextStyle(color: const Color(0xFF424242)),
                              border: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: greenFixed))),
                        ),
                      ))),
              Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  elevation: 4,
                  color: Colors.white,
                  child: new Theme(
                      data: new ThemeData(
                        hintColor: Colors.green,
                        primaryColor: Colors.green,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child:TextField(
                        controller: _controllerPass2,
                        focusNode: pass2Focus,
                        style: TextStyle(color: blackFixed),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (onvalue) {
                          passFocus.unfocus();
                          userFocus.unfocus();
                          pass2Focus.unfocus();
                          nameFocus.unfocus();
                          surnameFocus.unfocus();
                          mobileFocus.unfocus();
                          if (_validateUsername &&
                              _validatePassword &&
                              _validateMobile &&
                              _validateSurname &&
                              _validateName &&
                              _validatePass2) {
                            UserModel userModel = new UserModel();
                            userModel.name = _controllerName.text;
                            userModel.surname = _controllerSurname.text;
                            userModel.mobile = _controllerMobile.text;
                            userModel.username = _controllerUsername.text;
                            userModel.password = _controllerPass.text;
                            userModel.password2 = _controllerPass2.text;
                            viewModel.buildRegister(lang, userModel);

                            setState(() {
                              status = true;
                            });
                          }
                        },
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
                                _validateMobile &&
                                _validatePass2) {
                              opacity = 1;
                            } else {
                              opacity = 0.5;
                            }
                          });
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                            hintText: "Confirm your password",
                            labelText: "Repeat Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: greenFixed)),
                            hintStyle: TextStyle(color: greenFixed),
                            labelStyle:
                                new TextStyle(color: const Color(0xFF424242)),
                            border: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: greenFixed))),
                      )))),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
