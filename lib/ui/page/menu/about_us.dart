import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class AboutUsPage extends StatelessWidget {
  String lang;
  Future future;
  String langCode;

  @override
  Widget build(BuildContext context) {
    langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
    }
    // TODO: implement build
    return Scaffold(
        backgroundColor: greyFixed,
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text("about_us")),
          backgroundColor: greenFixed,
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: new FutureBuilder(
                  future: Networks().aboutus(lang),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        String body = snapshot.data[1]['body'] ?? "";
                        String markdown = html2md.convert(body);
                        return ListView(
                          children: <Widget>[
                            new Container(
                                margin: EdgeInsets.all(16),
                                child: new MarkdownBody(
                                  data: markdown,
                                )),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return loading();
                    } else {
                      return Container();
                    }
                  }),
            )));
  }
}
