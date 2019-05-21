import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/data/model/shop_item_model.dart';
import 'package:kendden_shehere/data/viewmodel/home_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class GroceryListItemOne extends StatefulWidget {
  Product product;
  HomeViewModel viewModel;

  GroceryListItemOne({this.product, this.viewModel});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryListItemOneState();
  }
}

class GroceryListItemOneState extends State<GroceryListItemOne> {
  Product product;

  @override
  Widget build(BuildContext context) {
    product = widget.product;

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: product.isAdded ? Colors.lightGreen : Colors.grey[300]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                color: Colors.grey.shade200,
                spreadRadius: 2.0)
          ]),
      margin: EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                        child: Image.network(
                          product.image,
                        ),
                        height: 150,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 4)),
                    onTap: () {
                      Navigator.pushNamed(context, "/product_detail");
                    },
                  ),
                  new GroceryTitle(text: product.title),
                  new Container(
                      height: 20,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new RatingStarWidget(1, 1, 16),
                              new Container(
                                child: Text("4.2"),
                              ),
                            ],
                          ),
                          new Container(
                            child: IconButton(
                              icon: Icon(
                                product.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pink[400],
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (product.isLiked) {
                                    product.isLiked = false;
                                    // widget.viewModel.onAddedProduct(shopItem);
                                  } else {
                                    product.isLiked = true;
                                    // widget.viewModel.onAddedProduct(shopItem);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new GrocerySubtitle(text: product.subtitle),
                      new GrocerySubtitle(text: product.price),
                    ],
                  ),
                  addedWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addedWidget() {
    if (!product.isAdded) {
      return new Container(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.green,
            size: 30,
          ),
          onPressed: () {
            setState(() {
              product.isAdded = true;
              widget.viewModel.addShopItem(product);
            });
          },
        ),
      );
    } else {
      return new Container(
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
                  product.amount--;
                  if (product.amount < 1) {
                    product.isAdded = false;
                    product.amount = 1;
                  }
                  widget.viewModel.removeShopItem(product);
                });
              },
            ),
            new Text(
              product.amount.toString(),
              style: new TextStyle(fontSize: 18),
            ),
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                setState(() {
                  product.amount++;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
