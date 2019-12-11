import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';

import '../home.dart';

class CampaignDetail extends StatelessWidget {
  String urll;

  CampaignDetail(this.urll);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
          title: new Text(AppTranslations.of(context).text('campaign')),
          backgroundColor: greenFixed,
          actions: <Widget>[
            GestureDetector(
                child: Image.asset('images/ks/chat.png'),
                onTap: () {
                  HomePage.getNewActivity();
                }),
          ]),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                urll,
                fit: BoxFit.cover,
              ),
              height: MediaQuery.of(context).size.height * 0.33,
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Padding(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Text(
                  'What is Lorem Ipsum?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
            )
          ],
        ),
      ),
    );
  }
}
