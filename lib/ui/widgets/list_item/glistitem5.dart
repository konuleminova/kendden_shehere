import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';

class GroceryListItemFive extends StatefulWidget {
  Product orderProduct;

  GroceryListItemFive(this.orderProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroceryListItemFiveState();
  }
}

class GroceryListItemFiveState extends State<GroceryListItemFive> {
  Product product;
  String title,image;
  int amount;

  @override
  Widget build(BuildContext context) {
    product = widget.orderProduct;
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
              borderRadius: BorderRadius.circular(20.0),
              elevation: 3.0,
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border:
                        new Border.all(width: 0.5, color: Colors.lightGreen)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new GroceryTitle(text: title),
                          //new GrocerySubtitle(text: product.counttype),
                          new GroceryTitle(text: product.price+" AZN"),
                          // new RatingStarWidget(5, 0, 20),
                          _statusWidget(),
                        ],
                      ),
                    ),
                  ),
              ))),
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (BuildContext context) => GroceryDetailsPage(product));
        Navigator.push(context, route);
      },
    );
  }
  _statusWidget() {
    return Text(
      product.weight.toString()+" kq",
      style: TextStyle(
          color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
