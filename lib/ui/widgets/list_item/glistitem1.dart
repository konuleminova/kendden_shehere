import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
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
//                    border: Border.all(
//                        color: !product.isAdded
//                            ? Colors.transparent
//                            : Colors.green[300]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.all(2.0),
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    } else if (onvalue['action'] == "removed") {
                                      // this.viewModel.changeLikeStatus(index, false);
                                      viewModel.removeWishItem(product);
                                    }
                                    print(onvalue);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          child: Container(
                            //color: Colors.green,
                            margin: EdgeInsets.only(bottom: 8,top: 8),
                            alignment: Alignment.center,
                            child: FadeInImage.assetNetwork(
                              image: "https://kenddenshehere.az/images/pr/th/" +
                                  product.code +
                                  ".jpg",
                              placeholder: "images/noimage.png",
                              fit: BoxFit.cover,
                              // height: 150,
                            ),
                            // height: 150,
//                              padding: EdgeInsets.only(
//                                  left: 10, right: 10, top: 10, bottom: 4)
                          ),
                          onTap: () {
                            //   Navigator.pushNamed(context, "/product_detail");
                            Route route = MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    GroceryDetailsPage(product));
                            Navigator.push(context, route);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new GroceryTitle(text: title),
                                  // new GrocerySubtitle(text: product.counttype),
                                  new GrocerySubtitle(
                                      text: product.price + " AZN"),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: addedWidget(),
                            )
                          ],
                        ),
                      ),
                      // Expanded(flex:1,child:    ),

//                      Expanded(
//                        child: new Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            new GroceryTitle(text: title),
//                            new Container(
//                                height: 20,
//                                child: new Row(
//                                  mainAxisAlignment:
//                                      MainAxisAlignment.spaceBetween,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    new Row(
//                                      children: <Widget>[
//                                        new RatingStarWidget(1, 1, 16),
//                                        new Container(
//                                          child: Text("4.2"),
//                                        ),
//                                      ],
//                                    ),
//                                    IconButton(
//                                      icon: Icon(
//                                          product.isLiked
//                                              ? Icons.favorite
//                                              : Icons.favorite_border,
//                                          color: Colors.pink[400],
//                                          size: 30),
//                                      onPressed: () {
//                                        setState(() {
//                                          if (!product.isLiked) {
//                                            product.isLiked = true;
//                                            // animationController.forward();
//                                          } else {
//                                            product.isLiked = false;
//                                            // animationController.reverse();
//                                          }
//                                        });
//                                        Networks()
//                                            .add_Remove_WishList(product.id)
//                                            .then((onvalue) {
//                                          if (onvalue != null) {
//                                            if (onvalue['action'] == "added") {
//                                              // this.viewModel.changeLikeStatus(index, true);
//                                              viewModel.addWishItem(product);
//                                            } else if (onvalue['action'] ==
//                                                "removed") {
//                                              // this.viewModel.changeLikeStatus(index, false);
//                                              viewModel.removeWishItem(product);
//                                            }
//                                            print(onvalue);
//                                          }
//                                        });
//                                      },
//                                    )
//                                  ],
//                                )),
//                            new GrocerySubtitle(text: product.counttype),
//                            new GrocerySubtitle(text: product.price + " AZN"),
//                          ],
//                        ),
//                        flex: 3,
//                      ),
//                      Expanded(
//                        child: addedWidget(),
//                      )
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
          child: CircleAvatar(
            backgroundColor: greenFixed,
            child: GestureDetector(
                child: Image.asset(
                  'images/ks/basket.png',
                  width: 24,
                  height: 24,
                ),
                onTap: () {
                  Networks()
                      .addToBasket(product.id, product.weight.toString())
                      .then((onvalue) {
                    if (onvalue != null) {
                      if (onvalue['action'] == "done") {
                        viewModel.addShopItem(product);
                        // viewModel.onFetchShopList();
                        //viewModel.changeAddStatus(index, true, product.weight);
                      }
                    }
                  });
                  setState(() {
                    product.isAdded = !product.isAdded;
                  });
                }),
          ),),
      secondChild: Container(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: const Color(0xFF0B4D17),
          child: GestureDetector(
              child: Image.asset(
                'images/ks/basket2.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                Networks().removeFromBasket(product.id)
                    .then((onvalue) {
                  if (onvalue != null) {
                    if (onvalue['action'] == "done") {
                      viewModel.removeShopItem(product);
                      // viewModel.onFetchShopList();
                      //viewModel.changeAddStatus(index, true, product.weight);
                    }
                  }
                });
                setState(() {
                  product.isAdded = !product.isAdded;
                });
              }),
        ),),
      crossFadeState: !product.isAdded
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 300),
      firstCurve: Curves.easeInToLinear,
      secondCurve: Curves.easeOutQuad,
    );
  }
}
