import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/product_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:redux/redux.dart';

class GroceryListItemOne extends StatefulWidget {
  Product product;

  GroceryListItemOne({this.product});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GroceryListItemOneState();
  }
}

class GroceryListItemOneState extends State<GroceryListItemOne>
    with SingleTickerProviderStateMixin {
  String title;
  Product product;
  ProductViewModel viewModel;

//  AnimationController animationController;
//  Animation animation;
  int currentState = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    animationController =
//        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
//    animation = Tween(begin: 28, end: 32.0).animate(animationController)
//      ..addListener(() {
//        setState(() {});
//      });
  }

  @override
  Widget build(BuildContext context) {
    product = widget.product;
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = product.name_az.trim();
    } else if (langCode == "en") {
      title = product.name_en.trim();
    } else if (langCode == "ru") {
      title = product.name_ru.trim();
    }
  //  int weight = product.weight;
    // TODO: implement build
    return StoreConnector(
        onInitialBuild: (ProductViewModel viewModel) {
          this.viewModel = viewModel;
        },
        onDispose: (store) {
          print("ON DISPOSE");
          // store.state.newProducts.clear();
        },
        converter: (Store<AppState> store) => ProductViewModel.create(store),
        builder: (BuildContext context, ProductViewModel viewModel) {
          return product != null
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: !product.isAdded
                              ? Colors.grey[300]
                              : Colors.green[300]),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10.0,
                            color: Colors.grey.shade200,
                            spreadRadius: 2.0)
                      ]),
                  margin: EdgeInsets.all(4.0),
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(flex:4,child: GestureDetector(
                        child: Container(
                            child: FadeInImage.assetNetwork(
                              image: "https://kenddenshehere.az/images/pr/th/" +
                                  product.code +
                                  ".jpg",
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
                      ),),
                  // Expanded(flex:1,child:    ),

                      Expanded(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                                    IconButton(
                                      icon: Icon(
                                          product.isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.pink[400],
                                          size: 30),
                                      onPressed: () {
                                        setState(() {
                                          if (!product.isLiked) {
                                            product.isLiked = true;
                                            // animationController.forward();
                                          } else {
                                            product.isLiked = false;
                                            // animationController.reverse();
                                          }
                                        });
                                        Networks()
                                            .add_Remove_WishList(product.id)
                                            .then((onvalue) {
                                          if (onvalue != null) {
                                            if (onvalue['action'] == "added") {
                                              // this.viewModel.changeLikeStatus(index, true);
                                              viewModel.addWishItem(product);
                                            } else if (onvalue['action'] ==
                                                "removed") {
                                              // this.viewModel.changeLikeStatus(index, false);
                                              viewModel.removeWishItem(product);
                                            }
                                            print(onvalue);
                                          }
                                        });
                                      },
                                    )
                                  ],
                                )),
                            new GrocerySubtitle(text: product.counttype),
                            new GrocerySubtitle(text: product.price + " AZN"),
                          ],
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: addedWidget(),
                      )
                    ],
                  ),
                )
              : SizedBox();
        });
  }

  addedWidget() {
    int weight = product.weight;
    return AnimatedCrossFade(
      firstChild: Container(
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
                      setState(() {
                        product.isAdded = !product.isAdded;
                      });
                      //viewModel.changeAddStatus(index, true, product.weight);
                    }
                  }
                });
              })),
      secondChild: new Container(
        height: 35,
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
                        setState(() {
                          product.isAdded = !product.isAdded;
                          product.weight = weight;
                        });
                        //viewModel.changeAddStatus(index, false, weight);
                      }
                    }
                  });
                } else {
                  Networks()
                      .addToBasket(product.id, weight.toString())
                      .then((onvalue) {
                    if (onvalue != null) {
                      if (onvalue['action'] == "done") {
                        setState(() {
                          // product.isAdded = !product.isAdded;
                          product.weight--;
                        });
                        //viewModel.changeAddStatus(index, true, weight);
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
                setState(() {
                  product.weight++;
                });
                Networks()
                    .addToBasket(product.id, weight.toString())
                    .then((onvalue) {
                  if (onvalue != null) {
                    if (onvalue['action'] == "done") {
                      //  viewModel.changeAddStatus(index, true, weight);
                      //viewModel.onFetchShopList();
                    }
                  }
                });
                //Networks().addToBasket(product.id, amount.toString());
              },
            ),
          ],
        ),
      ),
      crossFadeState: !product.isAdded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
      firstCurve: Curves.easeInToLinear,
      secondCurve: Curves.easeOutQuad,
    );
  }
}
