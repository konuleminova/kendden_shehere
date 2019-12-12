import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/information/information.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class FagPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FAGState();
  }
}

class FAGState extends State<FagPage> {
  double width;
  String lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
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
          centerTitle: true,
            title: Text(AppTranslations.of(context).text("fag")),
            backgroundColor: greenFixed),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: new Container(
            child: new FutureBuilder(
                future: Networks().fag(lang),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    ListInfo information = snapshot.data;
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: information.info.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                child: ExpansionTile(
                                  trailing: SizedBox(),
                                  title: Text(
                                    html2md.convert(information.info[index].q),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        html2md
                                            .convert(information.info[index].a),
                                        style: TextStyle(color: blackFixed),
                                      ),
                                    )
                                  ],
                                ));
//                            return _buildFagQuestionItem(
//                                html2md.convert(information.info[index].q),
//                                html2md.convert(information.info[index].a),
//                                expanded[index],
//                                index);
                          });
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return loading();
                  } else {
                    return Container();
                  }
                }),
          ),
        ));
  }
}
