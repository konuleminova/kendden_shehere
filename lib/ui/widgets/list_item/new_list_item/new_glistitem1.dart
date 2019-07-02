import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/redux/home/home_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class GroceryListItemOne extends StatefulWidget {
  NewProduct product;

  GroceryListItemOne({this.product});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryListItemOneState();
  }
}

class GroceryListItemOneState extends State<GroceryListItemOne> {
  NewProduct product;
  String title;
  String img;
  bool isAdded = false, isLiked = false;
  int amount = 1;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    img = product.hasphoto;
    if (img == "1") {
      print(product.code);
      img = "https://kenddenshehere.az/images/pr/th/" + product.code + ".jpg";
    } else {
      img = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = product.name_az.trim();
    } else if (langCode == "en") {
      title = product.name_en.trim();
    } else if (langCode == "ru") {
      title = product.name_ru.trim();
    }
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]),
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
                        child: img == null
                            ? Image.asset(
                                'images/noimage.png',
                                width: 285.0,
                                alignment: Alignment.center,
                              )
                            : Image.network(img),
                        height: 150,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 4)),
                    onTap: () {
                      //   Navigator.pushNamed(context, "/product_detail");
                      Route route = MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GroceryDetailsPage(product));
                      Navigator.push(context, route);
                    },
                  ),
                  new GroceryTitle(text: title),
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
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pink[400],
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  isLiked = !isLiked;
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
                      new GrocerySubtitle(text: product.counttype),
                      new GrocerySubtitle(text: product.price + " AZN"),
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
    if (!isAdded) {
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
                isAdded = true;
                //  widget.viewModel.addShopItem(product);
              });
            }),
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
                  amount--;
                  if (amount < 1) {
                    isAdded = false;
                    amount = 1;
                  }
                  // widget.viewModel.removeShopItem(product);
                });
              },
            ),
            new Text(
              amount.toString(),
              style: new TextStyle(fontSize: 18),
            ),
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                setState(() {
                  amount++;
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
