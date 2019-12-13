import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/page/create_new_pass.dart';

class PasswordResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenFixed,
        leading: Container(),
        centerTitle: true,
        title: Text(
          AppTranslations.of(context).text('pass_reset'),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: new BoxDecoration(color: greyFixed),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Image.asset('images/ks/pass_reset.png'),
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
                                    hintText: AppTranslations.of(context)
                                        .text('enter_email'),
                                    labelText: AppTranslations.of(context)
                                        .text('email'),
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
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "OR",
                        style: TextStyle( fontSize: 16,color: Colors.grey),
                      ),
                    ),
                    Card(
                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        elevation: 4,
                        color: Colors.white,
                        child: new Theme(
                            data: new ThemeData(
                              hintColor: Colors.green,
                              primaryColor: Colors.green,
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  maxLength: 9,
                                  decoration: InputDecoration(
                                      hintText: AppTranslations.of(context)
                                          .text('enter_mobile'),
                                      counterText: "",
                                      hintStyle: TextStyle(color: greenFixed),
                                      border: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greenFixed)),
                                      labelText: AppTranslations.of(context)
                                          .text('mobile'),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greenFixed)),
                                      icon: Text(
                                        "+994",
                                        style: TextStyle(
                                            color: blackFixed,
                                            fontWeight: FontWeight.bold),
                                      )),
                                )))),
                    SizedBox(height: 24,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: greenFixed,
                          onPressed: () {
                            Route route=MaterialPageRoute(builder: (BuildContext context)=>CreateNewPassPage());
                            Navigator.push(context, route);
                          },
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
