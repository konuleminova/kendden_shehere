import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/size.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:photo_view/photo_view.dart';

class CampaignsPage extends StatelessWidget {
  //List<String> photos;

  //CampaignsPage({this.photos});

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
                  if (snapshot.hasData) {
                    return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 5 / 4,
                        children: List<Widget>.generate(
                            snapshot.data.length - 1, (index) {
                          return GridTile(
                              child: GestureDetector(
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.all(6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Image(
                                        image: NetworkImage(
                                          snapshot.data[index + 1],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      flex: 3,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Hədiyyə Kartımız sahiblərini gözləyir',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            "Daha ətraflı...",
                                            style: TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, SizeRoute(page: new Scaffold(
                                  backgroundColor: Colors.black87,
                                  body: Stack(
                                    children: <Widget>[
                                      Center(
                                          child: new Container(
                                              child: PhotoView(imageProvider: NetworkImage(snapshot.data[index+1])))),
                                      Positioned(
                                          top: 30.0,
                                          left: 16.0,
                                          child: CircleAvatar(child: IconButton(
                                            color: Colors.white,
                                            iconSize: 30,
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),radius: 24,backgroundColor: Colors.grey,)
                                      )
                                    ],
                                  ))));
                            },
                          ));
                        }));
                  } else {
                    return loading();
                  }
                })));
  }
}
