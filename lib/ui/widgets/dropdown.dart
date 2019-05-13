import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
class DropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Show Dialog'),
        backgroundColor: Color(0xff8c3a3a),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }
static   void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      print('I First Item');
    } else if (choice == Constants.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants.ThirdItem) {
      print('I Thired Item');
    }
  }
}