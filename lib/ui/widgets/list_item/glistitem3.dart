import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/product_viewmodel.dart';
import 'package:kendden_shehere/redux/productlist/productlist_action.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:redux/redux.dart';

class GroceryListItemThree extends StatefulWidget {
  Product product;

  GroceryListItemThree(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewGroceryListItemTwoState();
  }
}

class NewGroceryListItemTwoState extends State<GroceryListItemThree> {
  Product product;
  String image, title;
  bool isAdded = false, isLiked = true;
  ProductViewModel viewModel;
  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    product = widget.product;
    product.isAdded = true;
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
    return StoreConnector(
        onInit: (store) {
          this.store = store;
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
              ? Card(
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
                                    child: FadeInImage.assetNetwork(
                                      image: image,
                                      placeholder: "images/noimage.png",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                  ),
                                  title: Container(
                                    height: 110.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new GroceryTitle(text: title),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        new Text(
                                          product.price + " AZN",
                                          style: TextStyle(
                                            color: greenFixed,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GroceryDetailsPage(product));
                                    Navigator.push(context, route);
                                  },
                                ),
                                flex: 7,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
//                                        GestureDetector(
//                                          child: Container(
//                                            child: Image.asset(
//                                                'images/ks/remove.png'),
//                                         decoration: BoxDecoration(color: greenFixed),
//                                            padding: EdgeInsets.all(4.0),
//
//                                          ),
//                                          onTap: () {
//                                            Networks()
//                                                .removeFromBasket(product.id)
//                                                .then((onvalue) {
//                                              if (onvalue != null) {
//                                                if (onvalue['action'] ==
//                                                    "done") {
//                                                  viewModel
//                                                      .removeShopItem(product);
//                                                  //viewModel.onHomeRefresh();
//                                                }
//                                              }
//                                            });
//                                          },
//                                        ),
                                        _updateContainer()
                                      ],
                                    ),
                                    height: MediaQuery.of(context).size.height,
                                  ))
                            ],
                          ))),
                )
              : SizedBox();
        });
  }

  _updateContainer() {
    int weight = product.weight;
    if (!product.isAdded) {
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
                height: 30,
                width: 30,
              ),
            ),
          ),
          onTap: () {
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
          });
    } else {
      return new Container(
        height: 40,
        alignment: Alignment.topRight,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: CircleAvatar(
              child: Container(
                child: GestureDetector(
                  child: new Icon(Icons.remove),
                  // iconSize: 20,
                  onTap: () {
                    setState(() {
                      // product.isAdded = !product.isAdded;
                      if (product.weight > 1) {
                        product.weight--;
                      }
                    });
                    Networks()
                        .addToBasket(product.id, weight.toString())
                        .then((onvalue) {
                      if (onvalue != null) {
                        if (onvalue['action'] == "done") {
                          store.dispatch(ShowBasketAction(store));
                          //viewModel.changeAddStatus(index, true, weight);
                        }
                      }
                    });
                  },
                ),
                alignment: Alignment.center,
              ),
              backgroundColor: greenFixed,
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              child: new Text(
                product.weight.toString(),
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 16,
                ),
              ),
            )),
            SizedBox(
              width: 4,
            ),
            Expanded(
                child: CircleAvatar(
              child: Container(
                  child: GestureDetector(
                child: new Icon(Icons.add),
                //iconSize: 20,
                onTap: () {
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
                        store.dispatch(ShowBasketAction(store));
                      }
                    }
                  });
                  //Networks().addToBasket(product.id, amount.toString());
                },
              )),
              backgroundColor: greenFixed,
            )),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    }
  }
}
