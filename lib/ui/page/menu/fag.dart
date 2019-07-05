import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kendden_shehere/localization/app_translations.dart';

class FagPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FAGState();
  }
}

class FAGState extends State<FagPage> {
  double width;
  List<bool> expanded = new List();
  String title;


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      expanded.add(false);
    }

  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    String langCode =
        Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = "assets/fag_az.txt";
    } else if (langCode == "en") {
      title = "assets/fag.txt";
    } else if (langCode == "ru") {
      title = "assets/fag_ru.txt";
    }

    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: Text(AppTranslations.of(context).text("fag")),
          backgroundColor: Colors.lightGreen,
        ),
        body:new Container(
          margin: EdgeInsets.all(16),
          child: new FutureBuilder(
              future: getFileData(title),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    String text = snapshot.data;
                   // List<String>  splits =text.split("\n");
                    return _buildFags(text,expanded);
                  }
                } else {
                  return Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              }),
        ),);
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  _buildFagQuestionItem(String text, String subtitle,bool expande,int index) => new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            child:Container(child: new Text(
              text,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),margin: EdgeInsets.only(bottom: 5,top: 5),),
            onTap: () {
              setState(() {
               expande = !expande;
               expanded[index]=expande;
              });
            },
          ),
          expande
              ? (new Container(
                  margin: EdgeInsets.only(top: 8,bottom: 8),
                  padding: EdgeInsets.all(12),
                  width: width,
                  child: new Text(
                    subtitle,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(5),
                      border: new Border.all(color: Colors.grey[400])),
                ))
              : new SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      );

  _buildFags(String text,List<bool> expanded) => ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildFagQuestionItem(text.split("\n")[index], "Subtitle",expanded[index],index);
        },
        itemCount: 12,
      );
}
