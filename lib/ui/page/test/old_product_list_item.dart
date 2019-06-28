import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class ProductItemWidget extends StatefulWidget {
  List<Product> productList;
  int index;

  ProductItemWidget(this.productList, this.index);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeListItemState();
  }
}

class HomeListItemState extends State<ProductItemWidget> {
  double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/product_detail");
      },
      child: new Container(
        margin: EdgeInsets.only(right: 4),
        width: 160,
        child: new Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRect(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Stack(
                    children: <Widget>[
                      new Container(
                          child: new Image.network(
                            widget.productList[widget.index].image,
                            fit: BoxFit.contain,
                          ),
                          width: width,
                          height: 100,
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 25, bottom: 4)),
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
                      margin: EdgeInsets.only(left: 8, top: 4),
                      child: RatingStarWidget(5, 4, 20.0)),
                  new Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: updateContainer(
                        widget.productList[widget.index].isAdded,
                        widget.index,
                      )),
                ],
              ),
            )),
      ),
    );
  }

  updateContainer(bool status, int index) {
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
                            widget.productList[index].amount =
                                widget.productList[index].amount - 1;
                            if (widget.productList[index].amount < 1) {
                              widget.productList[index].isAdded = false;
                              widget.productList[index].amount = 1;
                            }
                          });
                        },
                      ),
                      new Text(
                        widget.productList[index].amount.toString(),
                        style: new TextStyle(fontSize: 18),
                      ),
                      new GestureDetector(
                        child: new Icon(Icons.add),
                        onTap: () {
                          setState(() {
                            widget.productList[index].amount =
                                widget.productList[index].amount + 1;
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
                  widget.productList[index].isAdded = true;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
