import 'package:flutter/material.dart';

var greyFixed = const Color(0xFFF3F3F3);
var greenFixed = const Color(0xFF34AB4A);
var blackFixed=const Color(0xFF3A3A3A);

class Constants {
  static const String FirstItem = 'Name: A-Z';
  static const String SecondItem = 'Name: Z-A';
  static const String ThirdItem = 'Cheap-Expensive';
  static const String FifthItem = 'Expensive-Cheap';
  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
    FifthItem
  ];
  static const List<String> deliveryTimes = <String>[
    "11:30-13:00",
    "13:00-19:30",
    "Tecili catdirilma",
    "Magazadan gotur"
  ];

  static const List<String> gender = <String>[
    "Female",
    "Male",
  ];
}
