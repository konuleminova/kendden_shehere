import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
class GroceryListItemOne extends StatelessWidget {

  String title;
  bool isAdded = false;
  NewProduct product = new NewProduct();
  ProductListViewModel viewModel;
  int index;
  GroceryListItemOne({this.viewModel, this.index});
  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    product = this.viewModel.productList[index];
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
                        child: FadeInImage.assetNetwork(
                          image: "https://kenddenshehere.az/images/pr/th/" + product.code + ".jpg",
                          placeholder: "images/noimage.png",
                          fit: BoxFit.cover,
                          height: 150,
                        ),
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
                          new InkWell(
                              focusColor: Colors.green,
                              highlightColor: Colors.green,
                              hoverColor: Colors.green,
                              child: IconButton(
                                icon: Icon(
                                  this.viewModel.productList[index].isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.pink[400],
                                  size: 30,
                                ),
                                onPressed: () {
                                  Networks()
                                      .add_Remove_WishList(product.id)
                                      .then((onvalue) {
                                    if (onvalue['action'] == "added") {
                                      this.viewModel.changeLikeStatus(index, true);
                                      viewModel.addWishItem(product);
                                    } else if (onvalue['action'] == "removed") {
                                      this.viewModel.changeLikeStatus(index, false);
                                      viewModel.removeWishItem(product);
                                    }
                                    print(onvalue);
                                  });
                                },
                              )),
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
    int weight = product.weight;
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
                Networks()
                    .addToBasket(product.id, product.weight.toString())
                    .then((onvalue) {
                  print(onvalue);
                  if (onvalue != null) {
                    if (onvalue['action'] == "done") {
                      viewModel.addShopItem(product);
                      // viewModel.onFetchShopList();
                      viewModel.changeAddStatus(index, true, product.weight);
                    }
                  }
                });
              }));
    } else {
      return new Container(
        height: 35,
//        padding: EdgeInsets.all(0),
//        margin: EdgeInsets.only(top: 4, bottom: 4),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        alignment: Alignment.topRight,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.remove),
              iconSize: 20,
              onPressed: () {
                weight--;
                if (weight < 1) {
                  weight = 1;
                  Networks().removeFromBasket(product.id).then((onvalue) {
                    print("REMOVE");
                    if (onvalue != null) {
                      if (onvalue['action'] == "done") {
                        viewModel.removeShopItem(product);
                        viewModel.changeAddStatus(index, false, weight);
                      }
                    }
                  });
                } else {
                  Networks()
                      .addToBasket(product.id, weight.toString())
                      .then((onvalue) {
                    if (onvalue != null) {
                      if (onvalue['action'] == "done") {
                        viewModel.changeAddStatus(index, true, weight);
                      }
                    }
                  });
                }
              },
            ),
            new Text(
              product.weight.toString(),
              style: new TextStyle(fontSize: 18),
            ),
            new IconButton(
              iconSize: 20,
              padding: EdgeInsets.all(4),
              icon: new Icon(Icons.add),
              onPressed: () {
                weight++;
                Networks()
                    .addToBasket(product.id, weight.toString())
                    .then((onvalue) {
                  if (onvalue != null) {
                    if (onvalue['action'] == "done") {
                      viewModel.changeAddStatus(index, true, weight);
                      //viewModel.onFetchShopList();
                    }
                  }
                });
                //Networks().addToBasket(product.id, amount.toString());
              },
            ),
          ],
        ),
      );
    }
  }
}
//              setState(() {
//                isAdded = true;
//                Networks().addToBasket(product.id, amount.toString())
//                    .then((onvalue) {
//                      widget.viewModel.shopItems.add(product);
//                  print(onvalue);
//                  SharedPrefUtil().setString(SharedPrefUtil().count, "0");
//                  SharedPrefUtil().getString(SharedPrefUtil().count).then((onValue){
//                    SharedPrefUtil().setString(
//                        SharedPrefUtil().count,(int.parse(onValue)+1).toString());
//                  });
//
//                });
//                //  widget.viewModel.addShopItem(product);
//              });