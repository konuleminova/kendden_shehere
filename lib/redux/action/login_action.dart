import 'package:kendden_shehere/data/model/login_model.dart';

class LoginAction {
  String username;
  String password;
  bool isLogin = false;
  STATUS status;

  LoginAction({this.username, this.password, this.isLogin, this.status});

}
