import 'package:flutter/material.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CardsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CardsState();
  }
}

class CardsState extends State<CardsPage> {
  var width;

  var increment = 1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Product List"),
        actions: <Widget>[
          new Container(
            child: DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                    items: <String>[
                      'Price:Lower to High',
                      'Price:High to Lower',
                      'Name:A-Z',
                      'Name:Z-A'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      return Text(value);
                    },
                    hint: new Container(
                      child: new Text(
                        "Sort By",
                      ),
                      margin: EdgeInsets.only(left: 3),
                    ))),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: new Border.all(width: 1, color: Colors.white),
            ),
          )
        ],
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: new SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 0.6),
              delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return new Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[100])),
                    margin: EdgeInsets.only(right: 4),
                    width: 160,
                    child: new Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ClipRect(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Stack(
                                children: <Widget>[
                                  new Container(
                                      child: new Image.asset(
                                        "images/img2.jpg",
                                        fit: BoxFit.contain,
                                      ),
                                      width: width,
                                      height: 120,
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 25,
                                          bottom: 4)),
                                  new Container(
                                    child: new Icon(
                                      Icons.favorite_border,
                                      size: 23,
                                      color: Colors.redAccent[100],
                                    ),
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.only(right: 8),
                                  )
                                ],
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 8, left: 8),
                                child: new Text(
                                  "Alma",
                                  style: new TextStyle(fontSize: 20),
                                ),
                              ),
                              new Container(
                                margin: EdgeInsets.only(top: 4, left: 8),
                                child: new Text(
                                  "2 AZN /1kq",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                alignment: Alignment.bottomLeft,
                              ),
                              new Container(
                                margin: EdgeInsets.only(left: 8, top: 4),
                                child: RatingStarWidget(5, 4, 20.0),
                              ),
                              new Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.lightGreen,
                                child: new Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    new Text(
                                      "Sebete elave et",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                ),
                              )
                            ],
                          ),
                        )));
              }),
            ),
          )
        ],
      ),
    );
  }

  _updateContainer(bool status, int index) {
    if (status) {
      return Stack(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.topLeft,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Text(
                    "1 AZN",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ),
                new Container(
                  child: new Text(
                    "1 eded",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(top: 8, bottom: 8),
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
                            increment = increment - 1;
                            if (increment < 1) {
                              //campaignList[index].status = false;
                              increment = 1;
                            }
                          });
                        },
                      ),
                      new Text(
                        increment.toString(),
                        style: new TextStyle(fontSize: 18),
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
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return new Container(
        margin: EdgeInsets.only(top: 16),
        child: Stack(
          children: <Widget>[
            new Container(
              alignment: Alignment.topLeft,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      "1 AZN",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "1 eded",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            new GestureDetector(
              child: new Container(
                child: new Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.lightGreen,
                  child: new SizedBox(
                    child: new Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    height: 20,
                    width: 20,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
              onTap: () {
                setState(() {
                  //campaignList[index].status = true;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
