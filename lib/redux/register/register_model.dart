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


  RegisterModel.fromJson(Map<String, dynamic> json)
    :  msuccess = json['msuccess'],
        name =  json["name"] != null ? ErrorModel.fromJson(json["name"]) : null,
        surname = json['surname'] != null ? ErrorModel.fromJson(json["surname"]) : null,
        mobile = json['mobile'] != null ? ErrorModel.fromJson(json["mobile"]) : null,
        login = json['login'] != null ? ErrorModel.fromJson(json["login"]) : null,
        pass = json['pass'] != null ? ErrorModel.fromJson(json["pass"]) : null;


//  factory RegisterModel.fromJson(Map<String, dynamic> json) {
//    print(json['msuccess']);
//    return RegisterModel(
//      msuccess:  json['msuccess'] as String,
//      name: ErrorModel.fromJson(json["name"]),
//      surname: ErrorModel.fromJson(json["surname"]),
//      mobile: ErrorModel.fromJson(json["mobile"]),
//      login: ErrorModel.fromJson(json["login"]),
//      pass: ErrorModel.fromJson(json["pass"]),
//    );
//  }

  @override
  String toString() {
    return 'RegisterModel{name: $name, surname: $surname, mobile: $mobile, login: $login, pass: $pass, msuccess: $msuccess}';
  }


}
