import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  var increment = 1;
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return StoreConnector(
      converter: (Store<AppState> store) => ShoppingCartViewModel.create(store),
      // onInit: (store) {},
      builder: (BuildContext context, ShoppingCartViewModel viewModel) {
        return new Scaffold(
            appBar: new AppBar(
              centerTitle: true,
              title: new Text(
                "Meyve",
              ),
              backgroundColor: Colors.lightGreen,
            ),
            body: new Container(
              margin: EdgeInsets.only(bottom: 16),
              child: new ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Container(
                        child: new Image(image: AssetImage('images/img3.jpg')),
                      ),
                      new Container(
                        child: new Icon(Icons.favorite_border,size: 30,color: Colors.redAccent[100],),
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.all(16),
                      )
                    ],
                  ),
                  new Container(
                    width: width,
                    margin: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Column(
                          children: <Widget>[
                            new Container(
                              child: new Text(
                                "Alma ",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 23),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            new Container(
                              child: new Text(
                                "2 AZN /1kq",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(top: 4),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        new Container(
                          child: _addWidget(),
                          alignment: Alignment.topRight,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 10, right: 16, top: 8),
                    child: new Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                        " Lorem Ipsum has been the industry's standard dummy text ever since the "
                        "1500s, when an unknown printer took a galley of type and scrambled it to make a "
                        "type specimen book. It has survived not only five centuries, "),
                  ),
                  new Container(
                      width: 100,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 8),
                      padding: EdgeInsets.all(10),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: new Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        // mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Container(
                            child: Icon(
                              Icons.share,
                              color: Colors.green,
                            ),
                          ),
                          new Text(
                            "Share",
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          )
                        ],
                      )),
                  new Container(
                    margin: EdgeInsets.all(8),
                    child: ratingStarWidget(),
                  ),
                  new Container(
                    decoration: BoxDecoration(
                        border: new Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(4)),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(10),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 8),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new CircleAvatar(
                                child: Icon(
                                  Icons.chat,
                                  size: 15,
                                ),
                                maxRadius: 16,
                                backgroundColor: Colors.green,
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 10),
                                child: new Text("Read Reviews (1)"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  _plusMinusWidget() => new Container(
        width: width * 0.45,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        alignment: Alignment.topRight,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new GestureDetector(
              child: new Icon(Icons.remove),
              onTap: () {
                setState(() {
                  if (increment > 0) {
                    increment = increment - 1;
                  }
                });
              },
            ),
            new Text(
              increment.toString(),
              style: new TextStyle(fontSize: 16),
            ),
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                setState(() {
                  increment = increment + 1;
                });
              },
            ),
          ],
        ),
      );

  _addWidget() => new GestureDetector(
        child: new Container(
          width: width * 0.45,
          child: new Container(
            padding: EdgeInsets.all(8),
            color: Colors.lightGreen,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  child: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  height: 20,
                  width: 20,
                ),
                new Container(
                  child: new Text(
                    "Sebete elave et",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        onTap: () {
          setState(() {});
        },
      );

  Widget ratingStarWidget() => SmoothStarRating(
        allowHalfRating: false,
        onRatingChanged: (v) {
          // rating = v;
          setState(() {});
        },
        starCount: 5,
        rating: 4,
        size: 28.0,
        color: Colors.green,
        borderColor: Colors.green,
      );
}
