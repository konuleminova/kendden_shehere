import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class NewGroceryListItemTwo extends StatefulWidget {
  NewProduct product;

  NewGroceryListItemTwo(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewGroceryListItemTwoState();
  }
}

class NewGroceryListItemTwoState extends State<NewGroceryListItemTwo> {
  NewProduct product;
  String image, title;
  bool isAdded = false, isLiked = true;
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    product = widget.product;
    image = "https://kenddenshehere.az/images/pr/th/" + product.code + ".jpg";
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = product.name_az.trim();
    } else if (langCode == "en") {
      title = product.name_en.trim();
    } else if (langCode == "ru") {
      title = product.name_ru.trim();
    }

    // TODO: implement build
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Material(
           // borderRadius: BorderRadius.circular(20.0),
            elevation: 4.0,
            child: new Container(
              height: 120,
              color: Colors.white,
              //  decoration: BoxDecoration( borderRadius: BorderRadius.circular(20.0),),
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Container(
                        height: 80.0,
                        width: 100,
                        child: Image.network(
                          image,
                          width: 80,
                          fit: BoxFit.contain,
                          //height: 80.0,
                        )),
                    title: Container(
                      height: 110.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GroceryTitle(text: title),
                          new GrocerySubtitle(text: product.price + " AZN"),
                          new GrocerySubtitle(text: product.counttype),
                        ],
                      ),
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.pink[400],
                          size: 25,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                        _updateContainer()
                    ],
                  ),
                  height: MediaQuery.of(context).size.height,
                ))
              ],
            ))),
      ),
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (BuildContext context) => GroceryDetailsPage(product));
        Navigator.push(context, route);
      },
    );
  }

  _updateContainer() {
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
            isAdded = true;
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
                  amount--;
                  if (amount < 1) {
                    isAdded = false;
                    amount = 1;
                  }
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
