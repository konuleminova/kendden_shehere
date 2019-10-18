import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/product_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/slide_left.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_big_image.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:share/share.dart';
import 'package:redux/redux.dart';

import 'grocery_shop_list.dart';

class GroceryDetailsPage extends StatefulWidget {
  Product product;

  GroceryDetailsPage(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryDetailsState();
  }
}

class GroceryDetailsState extends State<GroceryDetailsPage> {
  var weight;
  String title, description;
  Product product;
  String img;
  ProductViewModel viewModel;
  int lenght;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    weight = product.weight;
    img = product.hasphoto;
    if (img == "1") {
      img = "https://kenddenshehere.az/images/pr/" + product.code + ".jpg";
    } else {
      img = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = product.name_az.trim();
      description = product.maininfo_az.trim();
    } else if (langCode == "en") {
      title = product.name_en.trim();
      description = product.maininfo_en.trim();
    } else if (langCode == "ru") {
      title = product.name_ru.trim();
      description = product.maininfo_ru.trim();
    }
    // TODO: implement build
    return StoreConnector(
        onInit: (store) {
          lenght = store.state.shopItems.length;
        },
        onInitialBuild: (ProductViewModel viewModel) {
          this.viewModel = viewModel;
        },
        onDispose: (store) {
          // store.state.newProducts.clear();
        },
        converter: (Store<AppState> store) => ProductViewModel.create(store),
        builder: (BuildContext context, ProductViewModel viewModel) {
          return product != null
              ? Scaffold(
                  appBar: new AppBar(
                      title: new Text(title),
                      backgroundColor: Colors.lightGreen,
                      actions: <Widget>[
                        InkWell(
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              final RenderBox box = context.findRenderObject();
                              Share.share(img,
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
                            },
                          ),
                        ),
                        new Stack(
                          children: <Widget>[
                            InkWell(
                              child: new IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  onPressed: null),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    SlideLeftRoute(
                                        page: GroceryShopCartPage(
                                      fromCheckout: false,
                                    )));
                              },
                            ),
                            lenght != 0
                                ? new Positioned(
                                    right: 11,
                                    top: 11,
                                    child: new Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 14,
                                        minHeight: 14,
                                      ),
                                      child: Text(
                                        lenght.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : new Container()
                          ],
                        ),
                      ]),
                  body: _buildPageContent(context))
              : SizedBox();
        });
  }

  Widget _buildPageContent(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              //_buildItemCard(context),
              GestureDetector(
                child: _buildItemImage(),
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (BuildContext context) => GroceryBigImage(
                            code: product.code,
                          ));
                  Navigator.push(context, route);
                },
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            GroceryTitle(text: title),
                            SizedBox(
                              height: 5.0,
                            ),
                            GrocerySubtitle(
                                text: product.counttype + " " + product.price+" AZN"),
                            new Container(
                              margin: EdgeInsets.all(6),
                              child: RatingStarWidget(5, 4, 22),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20, top: 8),
                      )),
                  Expanded(
                    child: new Container(
                      child: addedWidget(),
                      margin: EdgeInsets.only(right: 20, top: 30, left: 20),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: GrocerySubtitle(text: description)),
            ],
          ),
        ),
      ],
    );
  }

  addedWidget() {
    if (!product.isAdded) {
      return new GestureDetector(
        child: new Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: new Container(
            // padding: EdgeInsets.all(8),
            color: Colors.lightGreen,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
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
                              lenght++;
                            });
                            //viewModel.changeAddStatus(index, true, product.weight);
                          }
                        }
                      });
                    }),
                new Container(
                  padding: EdgeInsets.only(right: 8.0),
                  child: new Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        onTap: () {
          Networks().addToBasket(product.id, weight.toString()).then((onvalue) {
            if (onvalue != null) {
              if (onvalue['action'] == "done") {
                viewModel.addShopItem(product);
                // viewModel.onFetchShopList();
                setState(() {
                  product.isAdded = !product.isAdded;
                  lenght++;
                });
                //viewModel.changeAddStatus(index, true, product.weight);
              }
            }
            // widget.viewModel.onAddedProduct(product);
          });
        },
      );
    } else {
      return new Container(
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
                          lenght--;
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
                Networks()
                    .addToBasket(product.id, weight.toString())
                    .then((onvalue) {
                  if (onvalue != null) {
                    if (onvalue['action'] == "done") {
                      //  viewModel.changeAddStatus(index, true, weight);
                      //viewModel.onFetchShopList();
                      setState(() {
                        product.weight++;
                      });
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

  Container _buildItemImage() {
    return Container(
      padding:
          EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0, bottom: 16.0),
      child: Material(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: new Center(
                      child: Hero(
                    child: FadeInImage.assetNetwork(
                      placeholder: "images/noimage.png",
                      image: img,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      fadeInCurve: Curves.bounceOut,
                      fit: BoxFit.cover,
                    ),
                    tag: product.id,
                  ))),
              Positioned(
                  bottom: 8.0,
                  right: 8.0,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        product.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.pink[400],
                        size: 36,
                      ),
                      onPressed: () {
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
                            setState(() {
                              product.isLiked = !product.isLiked;
                            });
                          }
                        });
                      },
                    ),
                  )),
            ],
          )),
    );
  }
}
