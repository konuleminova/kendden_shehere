import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/localization/application.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/product_model.dart';
import 'package:kendden_shehere/data/model/shop_model.dart';
import 'package:kendden_shehere/data/viewmodel/home_viewmodel.dart';
import 'package:kendden_shehere/ui/page/test/old_test_cards.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_list.dart';
import 'package:kendden_shehere/ui/widgets/drawer.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:kendden_shehere/ui/page/test/old_product_list_item.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:kendden_shehere/ui/widgets/search.dart';
import 'package:kendden_shehere/util/carousel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Product> productList;
  ScrollController _scrollController, _scrollControllerSecond;
  String message;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeViewModel viewModel;
  int page = 0;
  double height = 0;
  double width = 0;
  final dataKey = new GlobalKey();
  int index = 4;
  var increment = 1;
  int counter = 0;
  List<String> photos = new List();

  var _current = 0;

  @override
  void initState() {
    productList = new List();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollControllerSecond = new ScrollController();
    _scrollControllerSecond.addListener(_scrollListenerSecond);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerSecond.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return StoreConnector(
        onInitialBuild: (HomeViewModel viewModel) {
          viewModel.onFetchProductList(10, page);
          this.viewModel = viewModel;
        },
        converter: (Store<AppState> store) => HomeViewModel.create(store),
        onInit: (store) {
          store.onChange.listen((onData) {
            if (onData != null) {
              try {
                productList.addAll(onData.products);
                // productList[0].status = true;
                //onData.home.data = productList;
                for (int i = 0; i < productList.length; i++) {
                  if (productList[i].isAdded) {
                    counter = 0;
                    print(productList[i].isAdded.toString() + i.toString());
                    setState(() {
                      counter++;
                    });
                  } else {
                    //counter--;
                  }
                }
                onData.home.products = productList;
                productList.clear();
                // productList[0].status=true;
                /*   for(int i=0;i<productList.length;i++){

                  if (productList[i].status) {
                    onData.shopItems.add(new ShopItem(
                        title: productList[i].title,
                        description: "Dummy Text",
                        price: "2 Azn"));
                  }
                }
                */

              } catch (exceptoon) {}
              // print("//" + onData.campaign.data.toString() + "...");
            }
          });
        },
        builder: (BuildContext context, HomeViewModel viewModel) {
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
                  child: new Text(AppTranslations.of(context).text("title_select_language")),
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
                      new IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              counter = 0;
                              Navigator.pushNamed(context, "/shopping_cart");
                            });
                          }),
                      counter != 0
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
                                  '$counter',
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
              body: new ListView(children: <Widget>[
                // _buildCarousel(),
                new SizedBox(
                  width: width,
                  height: 200,
                  child: new PageView(children: <Widget>[
                    new FutureBuilder(
                        future: Networks.bannerImages(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                GestureDetector(
                  child: _titleContainer(),
                  onTap: () {
                    Route route = MaterialPageRoute(
                        builder: (context) => GroceryListPage("titile"));
                    return Navigator.push(context, route);
                  },
                ),
                _buildCard(),
                GestureDetector(
                  child: _titleContainer(),
                ),
                //  _buildCard()
              ]));
        });
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

  _titleContainer() => new Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        height: 60,
        color: Colors.grey[200],
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Text(
                "Popular Mehsullar ",
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 20, color: Colors.green),
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            new Container(
              child: new Text(
                "See All ",
                textAlign: TextAlign.left,
                style: new TextStyle(fontSize: 15),
              ),
              alignment: AlignmentDirectional.centerEnd,
            )
          ],
        ),
      );

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        print(message);
        loadMore();
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the top";
        print(message);
      });
    }
  }

  _scrollListenerSecond() {
    if (_scrollControllerSecond.offset >=
            _scrollControllerSecond.position.maxScrollExtent &&
        !_scrollControllerSecond.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        print(message);
        loadMore();
      });
    }
    if (_scrollControllerSecond.offset <=
            _scrollControllerSecond.position.minScrollExtent &&
        !_scrollControllerSecond.position.outOfRange) {
      setState(() {
        message = "reach the top";
        print(message);
      });
    }
  }

  void loadMore() {
    page++;
    if (viewModel != null) {
      viewModel.onFetchProductList(10, page);
    }
  }

  _buildCard() => new Container(
        padding: EdgeInsets.all(8.0),
        child: new ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                width: width * 0.48,
                height: 350,
                child: InkWell(
                  child: GroceryListItemOne(
                    product: productList[index],
                    viewModel: viewModel,
                  ),
                ));
          },
          itemCount: productList.length,
        ),
        width: width,
        height: 340,
      );
}
//Search Widget
