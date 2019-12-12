import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ComplaintsPageState();
  }
}

class ComplaintsPageState extends State<ComplaintsPage> {
  String lang;
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  String _value1;
  String _value2;
  List<String> compaints = [
    'Mehsulun Keyfiyyeti',
    'Catdirilma',
    'Xidmetin Ehatesi',
    'Xidmetin Keyfiyyeti',
    'Saytin Isleme Prinsipi',
    'Saytin interfeysi',
    'Diger'
  ];

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
    }

    // TODO: implement build
    return new Scaffold(
        backgroundColor: greyFixed,
        appBar: new AppBar(
          title:
              Text(AppTranslations.of(context).text("suggestion_or_complaint")),
          backgroundColor: greenFixed,
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(16),
                  child: _value1 == null
                      ? Container(
                          //margin: EdgeInsets.all(16.0),
                          child: ExpansionTile(
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: greenFixed,
                            ),
                            title: Text(
                                'Sizə göstərilən xidmətdən ümumi məmnuniyyət səviyyəniz:'),
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    AppTranslations.of(context).text("poor")),
                                onTap: () {
                                  setState(() {
                                    _value1 = AppTranslations.of(context)
                                        .text("poor");
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                    AppTranslations.of(context).text("normal")),
                                onTap: () {
                                  setState(() {
                                    _value1 = AppTranslations.of(context)
                                        .text("normal");
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                    AppTranslations.of(context).text("good")),
                                onTap: () {
                                  setState(() {
                                    _value1 = AppTranslations.of(context)
                                        .text("good");
                                  });
                                },
                              ),
                            ],
                            initiallyExpanded: isExpanded1,
                            onExpansionChanged: (value) {
                              if (value) {
                                print(value);
                              }
                            },
                            backgroundColor: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                        )
                      : Container(
                          child: ListTile(
                            title: Text(_value1),
                            onTap: () {
                              setState(() {
                                _value1 = null;
                                isExpanded1 = true;
                              });
                            },
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                          //  padding: EdgeInsets.all(4.0),
                          margin: EdgeInsets.all(4.0),
                        ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  elevation: 4,
                ),
                Card(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: _value2 == null
                      ? Container(
                          // margin: EdgeInsets.all(16.0),
                          child: ExpansionTile(
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: greenFixed,
                            ),
                            title: Text(
                                'Təklif və ya şikayətiniz nə ilə bağlıdır?'),
                            children: <Widget>[
                              Container(
                                height: 220,
                                child: ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      title: Text(compaints[index]),
                                      onTap: () {
                                        setState(() {
                                          _value2 = compaints[index];
                                          isExpanded2 = true;
                                        });
                                      },
                                    );
                                  },
                                  itemCount: compaints.length,
                                ),
                              )
                            ],
                            backgroundColor: Colors.white,
                            initiallyExpanded: isExpanded2,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                        )
                      : Container(
                          child: ListTile(
                            title: Text(_value2),
                            onTap: () {
                              setState(() {
                                _value2 = null;
                                isExpanded2 = true;
                              });
                            },
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                          margin: EdgeInsets.all(4.0),
                        ),
                ),
                Card(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Təklif və ya iradınız",
                          border: InputBorder.none),
                      maxLines: 10,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0)),
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.all(4.0),
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(30.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            color: greenFixed,
                            disabledColor: greenFixed,
                            onPressed: null,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            child: Text(
                              AppTranslations.of(context).text('send'),
                              style: TextStyle(color: Colors.white),
                            )),
                      )),
                )
              ],
            )));
  }
}
