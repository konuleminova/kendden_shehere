import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';

class CreateNewPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(color: greyFixed),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Image.asset('images/ks/create_new_pass.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.only(left: 16,right: 16),
                        elevation: 4,
                        //padding: EdgeInsets.only(left: 4.0),
                        color: Colors.white,
                        child: new Theme(
                            data: new ThemeData(
                              hintColor: Colors.green,
                              primaryColor: Colors.green,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: TextField(
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: greenFixed)),
                                    labelText:AppTranslations.of(context)
                                        .text('create_new_pass'),
                                    hintStyle: TextStyle(color: greenFixed),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                        new BorderSide(color: greenFixed))),
                              ),
                            )
                          // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                        )),
                    SizedBox(height: 32,),
                    Card(
                        margin: EdgeInsets.only(left: 16,right: 16),
                        elevation: 4,
                        //padding: EdgeInsets.only(left: 4.0),
                        color: Colors.white,
                        child: new Theme(
                            data: new ThemeData(
                              hintColor: Colors.green,
                              primaryColor: Colors.green,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: TextField(
                                decoration: new InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: greenFixed)),
                                    labelText:AppTranslations.of(context)
                                        .text('repeat_new_pass'),
                                    hintStyle: TextStyle(color: greenFixed),
                                    labelStyle: new TextStyle(
                                        color: const Color(0xFF424242)),
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                        new BorderSide(color: greenFixed))),
                              ),
                            )
                          // margin: EdgeInsets.only(left: 20, top: 16, right: 20),
                        )),
                    SizedBox(height: 24,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: greenFixed,
                          onPressed: () {},
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(40.0))),
                          child: Text(
                            AppTranslations.of(context).text('send'),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
