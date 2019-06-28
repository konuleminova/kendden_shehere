import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/login/new_user_model.dart';
import 'package:kendden_shehere/main.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/login/login_viewmodel.dart';
import 'package:kendden_shehere/redux/app/app_state_reducer.dart';
import 'package:kendden_shehere/ui/page/index.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector(
      converter: (Store<AppState> store) => ViewModel.create(store),
      onInit: (store) {
        store.onChange.listen((state) {
          if (state.user_info.status == STATUS.FAIL ||
              state.user_info.status == STATUS.NETWORK_ERROR ||
              state.user_info.status == STATUS.SUCCESS) {
            status = false;
          }
        });
      },
      builder: (BuildContext context, ViewModel viewModel) => Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              decoration: new BoxDecoration(color: Colors.lightGreen),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0)),
                        new Container(
                          child: TextField(
                            onSubmitted: (value) {
                              //_controllerUsername.text=value;
                              userFocus.unfocus();
                              FocusScope.of(context).requestFocus(passFocus);
                            },
                            onChanged: (value) {
                              passFocus.unfocus();
                              setState(() {
                                _controllerUsername.text.isEmpty
                                    ? _validateUsername = false
                                    : _validateUsername = true;
                                if (_validateUsername && _validatePassword) {
                                  opacity = 1;
                                } else {
                                  opacity = 0.5;
                                }
                              });
                            },
                            controller: _controllerUsername,
                            textInputAction: TextInputAction.next,
                            focusNode: userFocus,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                ),
                                suffixIcon: Icon(
                                  Icons.check_circle,
                                  color: Colors.black26,
                                ),
                                hintText: "Username",
//                                errorText: !_validateUsername
//                                    ? "Field can't be empty."
//                                    : null,
                                hintStyle: TextStyle(color: Colors.black26),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                          margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                        ),
                        new Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            onSubmitted: (value) {
                              //_controllerPass.text=value;
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
                            onChanged: (value) {
                              userFocus.unfocus();
                              setState(() {
                                _controllerPass.text.isEmpty
                                    ? _validatePassword = false
                                    : _validatePassword = true;
                                if (_validateUsername && _validatePassword) {
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.black26,
                                ),
                                hintText: "Password",
//                                errorText: !_validateUsername
//                                    ? "Field can't be empty."
//                                    : null,
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        ),
                        Opacity(
                          opacity: opacity,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(30.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              color: Colors.green[700],
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
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: _showProgress(),
                            ),
                          ),
                        ),
                        Text("Forgot your password?",
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Connect with"),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text("Facebook"),
                                textColor: Colors.white,
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text("Twitter"),
                                textColor: Colors.white,
                                color: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Dont have an account?"),
                            FlatButton(
                              child: Text("Sign up"),
                              textColor: Colors.indigo,
                              onPressed: () {
                                return Navigator.pushNamed(
                                    context, "/register");
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
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
      return Text("Login", style: TextStyle(color: Colors.white70));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
