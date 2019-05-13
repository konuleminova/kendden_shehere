import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:kendden_shehere/data/viewmodel/login_viewmodel.dart';
import 'package:kendden_shehere/redux/reducer/app_state_reducer.dart';
import 'package:kendden_shehere/ui/page/index.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

void _showToast(BuildContext context, String content) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(content),
    action:
        SnackBarAction(label: "UNDO", onPressed: scaffold.hideCurrentSnackBar),
  ));
}

Widget get _loadingView {
  return new Center(
    child: new CircularProgressIndicator(),
  );
}

class LoginState extends State<LoginPage> {
  TextEditingController _controllerUsername, _controllerPass;
  bool _validateUsername = false;
  bool _validatePassword = false;

  @override
  Widget build(BuildContext context) {
    _controllerUsername = TextEditingController();
    _controllerPass = TextEditingController();

    // TODO: implement build
    return StoreConnector(
      converter: (Store<AppState> store) => ViewModel.create(store),
      onInit: (store) {
        store.onChange.listen((state) {
          if (state != null) {
            if (state.user_info.status == STATUS.SUCCESS) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
              //Navigator.pushNamed(context, "/home");
            } else if (state.user_info.status == STATUS.LOADING) {
              print("loading..");
            } else if (state.user_info.status == STATUS.FAIL) {
              _showToast(context, "Username or Password is wrong.");
            } else if (state.user_info.status == STATUS.NETWORK_ERROR) {
              _showToast(context, "No internet connection");
            }
          }
        });
      },
      builder: (BuildContext context, ViewModel viewModel) => Scaffold(
              body: SingleChildScrollView(child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen,
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
                              controller: _controllerUsername,
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
                                  errorText: _validateUsername
                                      ? "Field can't be empty."
                                      : null,
                                  hintStyle: TextStyle(color: Colors.black26),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0)),
                            ),
                            margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                          ),
                          new Container(
                            margin: EdgeInsets.all(16),
                            child: TextField(
                              controller: _controllerPass,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black26,
                                  ),
                                  hintText: "Password",
                                  errorText: _validateUsername
                                      ? "Field can't be empty."
                                      : null,
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(30.0),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              color: Colors.green[700],
                              onPressed: () {
                                print("click");
                                setState(() {
                                  _controllerUsername.text.isEmpty
                                      ? _validateUsername = true
                                      : _validateUsername = false;
                                  _controllerPass.text.isEmpty
                                      ? _validatePassword = true
                                      : _validatePassword = false;
                                });
                                if (!_validateUsername) {
                                  viewModel.buildLogin(_controllerUsername.text,
                                      _controllerPass.text);
                                }
                              },
                              elevation: 11,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                              child: Text("Login",
                                  style: TextStyle(color: Colors.white70)),
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
                                  return Navigator.pushNamed(context, "/register");
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),)),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerUsername.dispose();
    _controllerPass.dispose();
  }
}
