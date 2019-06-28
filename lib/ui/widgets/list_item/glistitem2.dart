import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class GroceryListItemTwo extends StatefulWidget {
  Product product;

  GroceryListItemTwo(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroceryListItemTwoState();
  }
}

class GroceryListItemTwoState extends State<GroceryListItemTwo> {
  Product product;
  String image, title, subtitle;
  bool isAdded, isLiked;

  int amount;

  @override
  Widget build(BuildContext context) {
    product = widget.product;
    image = product.image;
    title = product.title;
    isLiked = product.isLiked;
    isAdded = product.isAdded;
    subtitle = product.subtitle;
    amount = widget.product.amount;

    // TODO: implement build
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 4.0,
            child: new Container(
              child: ListTile(
                leading: Container(
                    height: 80.0,
                    width: 100,
                    child: Image.network(
                      image,
                      //height: 80.0,
                    )),
                title: Container(
                  height: 110.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new GroceryTitle(text: title),
                      new GrocerySubtitle(text: subtitle),
                      new GrocerySubtitle(text: product.price),
                    ],
                  ),
                ),
                trailing: Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        product.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.pink[400],
                      ),
                      onPressed: () {
                        setState(() {
                          if (product.isLiked) {
                            product.isLiked = false;
                          } else {
                            product.isLiked = true;
                          }
                        });
                      },
                    ),
                    _updateContainer(isAdded)
                  ],
                ),
              ),
              color: Colors.white,
            )),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/product_detail");
      },
    );
  }

  _updateContainer(bool isAdded) {
    if (!isAdded) {
      return new GestureDetector(
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
        ),
        onTap: () {
          setState(() {
            widget.product.isAdded = true;
          });
        },
      );
    } else {
      return new Container(
        width: 80,
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
                  widget.product.amount--;
                  if (widget.product.amount < 1) {
                    widget.product.isAdded = false;
                    widget.product.amount = 1;
                  }
                });
              },
            ),
            new Text(
              widget.product.amount.toString(),
              style: new TextStyle(fontSize: 18),
            ),
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                setState(() {
                  widget.product.amount++;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
