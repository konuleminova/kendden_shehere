import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/login_model.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum STATUS { SUCCESS, FAIL, LOADING, NETWORK_ERROR }

class NewUserModel {
  String id;
  String name;
  String surname;
  String password;
  String email;
  String mobile;
  String address;
  bool isLogin = false;
  STATUS status;
  String error;
  String message;

  NewUserModel(
      {this.id,
      this.name,
      this.surname,
      this.email,
      this.mobile,
      this.address,
      this.isLogin,
      this.status,
      this.error,
      this.message,
      this.password});

  static fromJson(json) {
    return NewUserModel(
        id: json['id'],
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        mobile: json['mobile'],
        address: json['address'],
        error: json['error'],
        message: json['message']);
  }

  NewUserModel copyWith(
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
    return NewUserModel(
        name: name ?? this.name,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        address: addresss ?? this.address,
        isLogin: isLogin ?? this.isLogin,
        status: status ?? this.status,
        error: error ?? this.error,
        message: message ?? this.message,
        password: password ?? this.password);
  }

  @override
  String toString() {
    return 'NewUserModel{id: $id, name: $name, surname: $surname, password: $password, email: $email, mobile: $mobile, address: $address, isLogin: $isLogin, status: $status, error: $error, message: $message}';
  }
}
