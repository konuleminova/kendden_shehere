import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: greyFixed,
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text("contact_us")),
          backgroundColor: greenFixed,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, top: 24, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ListTile(
                leading: Image.asset(
                  'images/ks/wp.png',
                ),
                title: Text(AppTranslations.of(context).text('wp')),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: greenFixed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'images/ks/call.png',
                ),
                title: Text(AppTranslations.of(context).text('call')),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: greenFixed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'images/ks/insta.png',
                ),
                title: Text(AppTranslations.of(context).text('insta')),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: greenFixed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'images/ks/fb.png',
                ),
                title: Text(AppTranslations.of(context).text('fb')),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: greenFixed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'images/ks/email.png',
                ),
                title: Text(AppTranslations.of(context).text('email')),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: greenFixed,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ],
          ),
        ));
  }
}
