import 'package:kendden_shehere/redux/register/error_model.dart';

class RegisterModel {
  ErrorModel name;
  ErrorModel surname;
  ErrorModel mobile;
  ErrorModel login;
  ErrorModel pass;
  String msuccess;

  RegisterModel(
      {this.name,
      this.surname,
      this.mobile,
      this.login,
      this.pass,
      this.msuccess});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: ErrorModel.fromJson(json["name"]),
      surname: ErrorModel.fromJson(json["surname"]),
      mobile: ErrorModel.fromJson(json["mobile"]),
      login: ErrorModel.fromJson(json["login"]),
      pass: ErrorModel.fromJson(json["pass"]),
      msuccess: json["msuccess"]??"0",
    );
  }

  @override
  String toString() {
    return 'RegisterModel{name: $name, surname: $surname, mobile: $mobile, login: $login, pass: $pass, msuccess: $msuccess}';
  }


}
