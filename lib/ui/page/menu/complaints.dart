import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class ComplaintsPage extends StatelessWidget {
  String lang;

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
    return new FutureBuilder(
        future: Networks().complaints(lang),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // ListInfo information = snapshot.data;
            if (snapshot.data != null) {
              String header = snapshot.data['header'] ?? "";
              String body = snapshot.data['body'] ?? "";
              String markdown = html2md.convert(body);
              return new Scaffold(
                  appBar: new AppBar(
                    title: Text(header),
                    backgroundColor: Colors.lightGreen,
                  ),
                  body: ListView(
                    children: <Widget>[
                      new Container(
                          margin: EdgeInsets.all(16),
                          child: new MarkdownBody(
                            data: markdown,
                          )),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Ad Soyad", border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white),
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(16.0),
                      ),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        child: ExpansionTile(
                          title: Text(
                              'Sizə göstərilən xidmətdən ümumi məmnuniyyət səviyyəniz:'),
                          children: <Widget>[
                            ListTile(
                              title: Text('Zeif'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Normal'),
                            ),
                            ListTile(
                              title: Text('Ela'),
                            ),
                          ],
                          backgroundColor: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        child: ExpansionTile(
                          title:
                              Text('Təklif və ya şikayətiniz nə ilə bağlıdır?'),
                          children: <Widget>[
                            ListTile(
                              title: Text('Zeif'),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text('Normal'),
                            ),
                            ListTile(
                              title: Text('Ela'),
                            ),
                          ],
                          backgroundColor: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0)),
                      ),
                      Container(
                        height: 100,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Təklif və ya iradınız",
                              border: InputBorder.none),
                          maxLines: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(16.0),
                      ),
                      Container(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Əlaqə vasitəsi",
                              border: InputBorder.none),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(16.0),
                      ),
                   Container(child:    RaisedButton(
                     color: Colors.green,
                     onPressed: () {
                     },
                     child: Row(
                       mainAxisAlignment:
                       MainAxisAlignment.spaceAround,
                       children: <Widget>[
                         Text("Gonder",
                             style: TextStyle(color: Colors.white)),
                       ],
                     ),
                   ),margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),)
                    ],
                  ));
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: loading(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Contacts",
                ),
                backgroundColor: Colors.lightGreen,
              ),
              body: Container(),
            );
          }
        });
  }
}
