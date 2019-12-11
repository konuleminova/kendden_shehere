import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';

import '../home.dart';

class CampaignDetail extends StatelessWidget {
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
    );
  }
}
