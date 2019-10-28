import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutUsPageState();
  }
}

class AboutUsPageState extends State<AboutUsPage> {
  String lang;
  Future future;
  String _title = "About us";

  @override
  void initState() {
    super.initState();
    future = Networks().aboutus(lang);
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.of(context).text("about_us")),
        backgroundColor: Colors.lightGreen,
      ),
      body: new FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ListInfo information = snapshot.data;
              if (snapshot.data != null) {
                String header = snapshot.data[0]['header'] ?? "";
                _title = header;
                String body = snapshot.data[1]['body'] ?? "";
                String markdown = html2md.convert(body);
                return SingleChildScrollView(
                  child: new Container(
                      margin: EdgeInsets.all(16),
                      child: new MarkdownBody(
                        data: markdown,
                      )),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loading();
            } else {
              return Container();
            }
          }),
    );
  }
}
