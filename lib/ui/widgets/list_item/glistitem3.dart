import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          // store.state.isDelete=false;
        },
        converter: (Store<AppState> store) => ProductViewModel.create(store),
        builder: (BuildContext context, ProductViewModel viewModel) {
          return product != null
              ? Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: new Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              leading: Container(
                                child: FadeInImage.assetNetwork(
                                  image: image,
                                  placeholder: "images/noimage.png",
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                              ),
                              title: Container(
                                height: 110.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8,right: 4),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                  Row(children: <Widget>[],),
                                    viewModel.isDelete
                                        ? GestureDetector(
                                            child: Card(
                                              margin: EdgeInsets.all(8),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                elevation: 8,
                                                child: Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: greenFixed,
                                                    size: 22,
                                                  ),
                                                )),
                                            onTap: () {
                                              viewModel.removeShopItem(product);
                                              Networks()
                                                  .removeFromBasket(product.id)
                                                  .then((onvalue) {
                                                if (onvalue != null) {
                                                  if (onvalue['action'] ==
                                                      "done") {
                                                    Fluttertoast.showToast(
                                                        msg: "Product removed",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIos: 1,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  }
                                                }
                                              });
                                            },
                                          )
                                        : SizedBox(),
                                    _updateContainer()
                                  ],
                                ),
                                height: MediaQuery.of(context).size.height,
                              ))
                        ],
                      )))
              : SizedBox();
        });
  }

  _updateContainer() {
    int weight = product.weight;
    return new Container(
      height: 70,
      alignment: AlignmentDirectional.centerEnd,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Card(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
              elevation: 4,
              child: Container(
                // color: greenFixed,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60), color: greenFixed),
//                radius: 20,
//                backgroundColor: greenFixed,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
                child: new Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                // height: 50,
                //  width: 50,
              ),
            ),
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
          SizedBox(
            width: 6,
          ),
          Container(
            child: new Text(
              product.weight.toString(),
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          GestureDetector(
            child: Card(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
              elevation: 4,
              child: Container(
                // color: greenFixed,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60), color: greenFixed),
//                radius: 20,
//                backgroundColor: greenFixed,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
                child: new Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                // height: 50,
                //  width: 50,
              ),
            ),
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
          ),
          SizedBox(
            width: 4,
          )
        ],
      ),
    );
  }
}
