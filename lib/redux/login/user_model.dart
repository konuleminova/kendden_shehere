import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum STATUS { SUCCESS, FAIL, LOADING, NETWORK_ERROR }

class UserModel {
  String id;
  String name;
  String surname;
  String password;
  String password2;
  String username;
  String mobile;
  String address;
  bool isLogin = false;
  STATUS status;
  String error;
  String message;

  UserModel(
      {this.id,
      this.name,
      this.surname,
      this.username,
      this.mobile,
      this.address,
      this.isLogin,
      this.status,
      this.error,
      this.message,
      this.password,this.password2});

  static fromJson(json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        username: json['email'],
        mobile: json['mobile'],
        address: json['address'],
        error: json['error'],
        message: json['message']);
  }

  UserModel copyWith(
      {String name,
      String surname,
      String email,
      String mobile,
      String addresss,
      bool isLogin,
      String error,
      String message,
      STATUS status,
      String password}) {
    return UserModel(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        username: email ?? this.username,
        mobile: mobile ?? this.mobile,
        address: addresss ?? this.address,
        isLogin: isLogin ?? this.isLogin,
        status: status ?? this.status,
        error: error ?? this.error,
        message: message ?? this.message,
        password: password ?? this.password,
        password2: password2 ?? this.password2);
  }

  @override
  String toString() {
    return 'NewUserModel{id: $id, name: $name, surname: $surname, password: $password, email: $username, mobile: $mobile, address: $address, isLogin: $isLogin, status: $status, error: $error, message: $message}';
  }
}
