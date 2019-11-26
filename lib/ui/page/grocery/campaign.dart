import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/home.dart';

class CampaignsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenFixed,
          actions: <Widget>[
            GestureDetector(
                child: Image.asset('images/ks/chat.png'),
                onTap: () {
                  HomePage.getNewActivity();
                }),
            SizedBox(
              width: 4,
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(8),
            child: FutureBuilder(
                future: Networks().bannerImages(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 5 / 4,
                      children:
                          List<Widget>.generate(snapshot.data.length, (index) {
                        return GridTile(
                            child: GestureDetector(
                          child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            child: Container(
                              margin: EdgeInsets.all(16),
                            ),
                          ),
                          onTap: null,
                        ));
                      }));
                })));
  }
}
