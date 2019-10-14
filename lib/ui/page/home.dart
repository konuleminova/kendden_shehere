import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_viewmodel.dart';
import 'package:kendden_shehere/redux/home/thunk_home.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/slide_left.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:kendden_shehere/ui/widgets/drawer.dart';
import 'package:kendden_shehere/ui/widgets/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double height = 0;
  double width = 0;
  var increment = 1;
  int counter = 0;
  List<String> photos = new List();
  var _current = 0;
  String title;
  ProductsInCategory productsInCategory = new ProductsInCategory();

  @override
  void initState() {
    Networks().getCollections().then((onValue) {
      setState(() {
        productsInCategory = onValue;
      });
    });
    Networks().showAllCollection().then((onValue){
      print("home");
      print(onValue);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return new StoreConnector(
        onInitialBuild: (ShoppingCartViewModel viewModel) {
          viewModel.onFetchShopList();
          counter=viewModel.shopItems.length;
        },

        onDidChange: (ShoppingCartViewModel viewModel){
          counter=viewModel.shopItems.length;
          setState(() {
            counter;
          });
        },
        onDispose: (store){
          store.state.shopItems.clear();
        },
        converter: (Store<AppState> store) => ShoppingCartViewModel.create(store),
        builder: (BuildContext context,ShoppingCartViewModel viewModel) {
          return new Scaffold(
              key: scaffoldKey,
              appBar: new AppBar(
                backgroundColor: Colors.lightGreen,
                leading: IconButton(
                  icon: new Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                ),
                title: GestureDetector(
                  child: new Text(
                      AppTranslations.of(context).text("title_select_language")),
                  onTap: () {
                    print("click");
                    application.onLocaleChanged(Locale("ru"));
                    //viewModel.changeLang("en");
                  },
                ),
                actions: <Widget>[
                  new IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: SearchWidget());
                    },
                  ),
                  new Stack(
                    children: <Widget>[
                      InkWell(child: new IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: null),onTap: (){
                        setState(() {
                          counter = 0;
                          Navigator.push(
                              context,
                              SlideLeftRoute(
                                  page: GroceryShopCartPage(
                                    fromCheckout: false,
                                  )));
                        });

                      },),
                      counter!=0
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
                            counter.toString(),
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
                ],
              ),
              floatingActionButton: new FloatingActionButton(
                backgroundColor: Colors.lightGreen,
                onPressed: () {
                  _getNewActivity();
                  // Navigator.pushNamed(context, "/online_chat");
                },
                child: new Icon(Icons.chat),
              ),
              drawer: DrawerWidget(),
              body: new Column(children: <Widget>[
                // _buildCarousel(),
                new SizedBox(
                  width: width,
                  height: 200,
                  child: new PageView(children: <Widget>[
                    new FutureBuilder(
                        future: Networks().bannerImages(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            photos = snapshot.data;
                            List<Widget> images = new List();
                            for (int i = 0; i < photos.length; i++) {
                              images.add(new Container(
                                width: width,
                                child: new Image(
                                  image: NetworkImage(photos[i]),
                                  fit: BoxFit.cover,
                                ),
                              ));
                            }
                            return _buildCarousel(images);
                          } else {
                            return Center(
                              child: new CircularProgressIndicator(),
                            );
                          }
                        })
                  ]),
                ),
//                Expanded(
//                  //height: height * 0.5,
//                    child: productsInCategory.productsInCategory != null
//                        ? ListView.builder(
//                        shrinkWrap: true,
//                        itemCount: productsInCategory.productsInCategory.length,
//                        itemBuilder: (
//                            BuildContext context,
//                            int index,
//                            ) {
//                          return Container(
//                              child: Column(
//                                children: <Widget>[
//                                  _titleContainer(productsInCategory
//                                      .productsInCategory[index].name_az),
//                                  FutureBuilder(
//                                      future: Networks().getCollectionItem(
//                                          productsInCategory
//                                              .productsInCategory[index].id),
//                                      builder: (BuildContext context,
//                                          AsyncSnapshot snapshot) {
//                                        if (snapshot.hasData) {
//                                          return Container(
//                                            child: ListView.builder(
//                                                physics: ClampingScrollPhysics(),
//                                                shrinkWrap: true,
//                                                scrollDirection: Axis.horizontal,
//                                                itemCount: snapshot.data.length,
//                                                itemBuilder: (BuildContext context,
//                                                    int index) {
//                                                  return Container(
//                                                    height: height * 0.5,
//                                                    child: Column(
//                                                      children: <Widget>[
//                                                        Container(
//                                                            width:
//                                                            MediaQuery.of(context)
//                                                                .size
//                                                                .width *
//                                                                0.5,
//                                                            height: height * 0.5,
//                                                            child: InkWell(
//                                                              child:
//                                                              GroceryListItemOne(
//                                                                  product: snapshot
//                                                                      .data[
//                                                                  index],viewModel: viewModel,),
//                                                            ))
//                                                      ],
//                                                    ),
//                                                  );
//                                                }),
//                                            height: height * 0.5,
//                                          );
//                                        } else {
//                                          return Center(
//                                            child: CircularProgressIndicator(),
//                                          );
//                                        }
//                                      }),
//                                ],
//                              ));
//                        })
//                        : Center(
//                        child: CircularProgressIndicator()
//                    )),
                // Container(child: Text("© 2019 Agro Trade",style: TextStyle(color: Colors.green),textAlign: TextAlign.end,),padding: EdgeInsets.all(8.0))


                //  _buildCard()
              ]));
        });
    // TODO: implement build
  }

  static const platform = const MethodChannel("kendden_shehere/chat_activity");

  _getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Widget _buildCarousel(List<Widget> images) => Container(
          child: new Stack(
        children: <Widget>[
          CarouselSlider(
            pauseAutoPlayOnTouch: const Duration(seconds: 1),
            items: images,
            autoPlay: true,
            height: 200,
            aspectRatio: 2.0,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(images, (index, url) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Colors.white
                            : const Color(0xFFABC2B1)),
                  );
                }),
              ))
        ],
      ));

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  _titleContainer(String title) => new Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        height: 60,
        color: Colors.grey[200],
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Text(
                title,
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 20, color: Colors.green),
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
//            new Container(
//              child: new Text(
//                "See All ",
//                textAlign: TextAlign.left,
//                style: new TextStyle(fontSize: 15),
//              ),
//              alignment: AlignmentDirectional.centerEnd,
//            )
          ],
        ),
      );

//  _buildCard() => new Container(
//        padding: EdgeInsets.all(8.0),
//        child: new ListView.builder(
//          scrollDirection: Axis.horizontal,
//          controller: _scrollController,
//          itemBuilder: (BuildContext context, int index) {
//            return Container(
//                width: MediaQuery.of(context).size.width * 0.5,
//                height: 360,
//                child: InkWell(
//                  child: GroceryListItemOne(
//                    product: productListOne[index],
//                  ),
//                ));
//          },
//          itemCount: productListOne.length,
//        ),
//        width: width,
//        height: 360,
//      );

//  void loadMore(String id) {
//    page = page + 10;
//    print(productListOne.toString() + "initial");
//    viewModel.onFetchProductList(id, "0", "66", page.toString(), "0");
//  }
//
//  _scrollListener() {
//    if (_scrollController.offset >=
//            _scrollController.position.maxScrollExtent &&
//        !_scrollController.position.outOfRange) {
//      setState(() {
//        message = "reach the bottom";
//        print(message);
//        loadMore("66");
//      });
//    }
//    if (_scrollController.offset <=
//            _scrollController.position.minScrollExtent &&
//        !_scrollController.position.outOfRange) {
//      setState(() {
//        message = "reach the top";
//        print(message);
//      });
//    }
//  }
}
//Search Widget
