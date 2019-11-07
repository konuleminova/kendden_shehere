import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class ContactsPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.of(context).text("contact_us")),
        backgroundColor: Colors.lightGreen,
      ),
      body: new FutureBuilder(
          future: Networks().contacts(lang),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ListInfo information = snapshot.data;
              if (snapshot.data != null) {
                String header = snapshot.data['header'] ?? "";
                String body = snapshot.data['body'] ?? "";
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
