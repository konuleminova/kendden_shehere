import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/connectivity/con_enum.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_error_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:kendden_shehere/ui/widgets/drawer.dart';
import 'package:kendden_shehere/ui/widgets/search.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:async/async.dart';

class HomePage extends StatelessWidget {
  double height = 0;
  double width = 0;
  List<String> photos = new List();
  String title;
  AsyncMemoizer memoizer = new AsyncMemoizer();
  HomeViewModel viewModel;
  bool fromCheckout;
  BuildContext context;
  Future _future;
  Future _future2;
  Store<AppState> _store;


  HomePage({this.fromCheckout});

  // GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //this.context = context;
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return WillPopScope(
        child: new StoreConnector(
            onInit: (store) {

              _store=store;
              _future = Networks().bannerImages();
              _future2=Networks().userinfo();
              store.state.wishItems.clear();
              store.state.shopItems.clear();
              print("INITT");
              if (fromCheckout) {
                print("FROM CHECKOUT");
                Networks().basket().then((onValue) {
                  if (context != null) {
                    if (onValue == '0') {
                      print("TRUEE");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PaymentSuccessDialog(context);
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PaymentErrorDialog(
                                context,
                                "Odeme heyate kecmedi.",
                                'Xahiş edirik əməliyyatı yenidən təkrarlayasınız.');
                          });
                    }
                  }
                });
              }
            },
            onInitialBuild: (HomeViewModel viewModel) {
              this.viewModel = viewModel;
              viewModel.onFetchShopList();
              viewModel.onFetchWishList();
              viewModel.onFetchAllCollection();
            },
            onDispose: (store) {
              store.state.homeList.homelist.clear();
              store.state.wishItems.clear();
              store.state.shopItems.clear();
            },
            onDidChange: (HomeViewModel viewModel) {
              print("On did chnage");
//             if(_store.state.homeList.homelist!=null){
//               if(_store.state.homeList.homelist.length<=0){
//                 print("Different");
//                 viewModel.onFetchAllCollection();
//               }
//             }
//              if(_store.state.wishItems!=null){
//                if(_store.state.wishItems.length<=0){
//                  print("Different");
//                  viewModel.onFetchWishList();
//                }
//              }
//              if(_store.state.shopItems!=null){
//                if(_store.state.shopItems.length<=0){
//                  print("Different");
//                  viewModel.onFetchShopList();
//                }
//              }
            },
            converter: (Store<AppState> store) => HomeViewModel.create(store),
            builder: (BuildContext context, HomeViewModel viewModel) {
              return new Scaffold(
                  //key: _scaffold,
                  appBar: new AppBar(
                    backgroundColor: Colors.lightGreen,
                    leading: Builder(
                      builder: (context) => IconButton(
                        icon: new Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    title: new Text(AppTranslations.of(context)
                        .text("title_select_language")),
                    actions: <Widget>[
                      new IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showSearch(
                              context: context, delegate: SearchWidget());
                        },
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
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          GroceryShopCartPage(
                                            fromCheckout: false,
                                          )));
                            },
                          ),
                          viewModel.shopItems.length != 0
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
                                      viewModel.shopItems.length.toString(),
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
                  drawer: new Drawer(
                    child: ListView(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            UserAccountsDrawerHeader(
                              accountName: new FutureBuilder(
                                future: _future2,
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return new Text(
                                      snapshot.data[1]['name'] +
                                          " " +
                                          snapshot.data[1]['surname'],
                                      style: new TextStyle(fontSize: 18),
                                    );
                                  } else {
                                    // default show loading while state is waiting
                                    return SizedBox();
                                  }
                                },
                              ),
                              accountEmail: new Text(""),
                              currentAccountPicture: CircleAvatar(
                                  minRadius: 60,
                                  backgroundColor: Colors.green.shade300,
                                  child: CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(
                                        'https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg'),
                                    backgroundColor: Colors.transparent,
                                  )),
                              decoration: new BoxDecoration(color: Colors.lightGreen),
                              onDetailsPressed: () {
                                Navigator.pushNamed<dynamic>(context, "/profile")
                                    .then((isLoggedOut) {
                                  if (isLoggedOut != null && isLoggedOut == true) {
                                    Navigator.pushReplacementNamed(context, '/login');
                                  }
                                });
                              },
                            ),
                            Container(
                              child: new IconButton(
                                icon: new Icon(Icons.settings),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/settings");
                                },
                                iconSize: 25,
                                disabledColor: Colors.white,
                                color: Colors.white,
                              ),
                              alignment: Alignment.topRight,
                            )
                          ],
                        ),
                        ListTile(
                          leading: Icon(Icons.category),
                          title: Text(AppTranslations.of(context).text("categories")),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new GroceryCategoriesPage(
                                        id: "0",
                                        title: AppTranslations.of(context)
                                            .text("categories"))));
                            // Navigator.pushNamed(context, "/categories");
                          },
                        ),
                        GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.favorite),
                            title: Text(AppTranslations.of(context).text("wish_list")),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/wish_list");
                          },
                        ),
                        GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.history),
                            title: Text(AppTranslations.of(context).text("order_history")),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/order_history");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.feedback),
                          title: Text(AppTranslations.of(context).text("delivery_terms")),
                          onTap: () {
                            Navigator.pushNamed(context, "/delivery_terms");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.question_answer),
                          title: Text(AppTranslations.of(context).text("fag")),
                          onTap: () {
                            Navigator.pushNamed(context, "/fag");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text(AppTranslations.of(context).text("about_us")),
                          onTap: () {
                            Navigator.pushNamed(context, "/about_us");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(AppTranslations.of(context).text("contact_us")),
                          onTap: () {
                            Navigator.pushNamed(context, "/contacts");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text(AppTranslations.of(context).text("complaints")),
                          onTap: () {
                            Navigator.pushNamed(context, "/complaints");
                          },
                        ),
                      ],
                    ),
                  ),
                  body: connectionStatus != ConnectivityStatus.Offline
                      ? RefreshIndicator(
                          child: SingleChildScrollView(
                              child: Stack(
                            children: <Widget>[
                              new Wrap(children: <Widget>[
                                // _buildCarousel(),
                                new SizedBox(
                                  width: width,
                                  height: 200,
                                  child: new PageView(children: <Widget>[
                                    new FutureBuilder(
                                        future: _future,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            photos = snapshot.data;
                                            List<Widget> imagesWidget =
                                                new List();
                                            for (int i = 0;
                                                i < photos.length;
                                                i++) {
                                              imagesWidget.add(new Container(
                                                width: width,
                                                child: new Image(
                                                  image: NetworkImage(
                                                    photos[i],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ));
                                            }
                                            return Carousel(
                                              images: imagesWidget,
                                              dotSize: 4.0,
                                              dotSpacing: 15.0,
                                              dotColor: Colors.lightGreenAccent,
                                              indicatorBgPadding: 5.0,
                                              dotBgColor: Colors.transparent,
                                              borderRadius: true,
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  new CircularProgressIndicator(),
                                            );
                                          }
                                        })
                                  ]),
                                ),

                                viewModel.homeList.homelist != null
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount:
                                            viewModel.homeList.homelist.length,
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          String langCode =
                                              Localizations.localeOf(context)
                                                  .languageCode;
                                          if (langCode == "tr") {
                                            title = viewModel.homeList
                                                .homelist[index].name_az
                                                .trim();
                                          } else if (langCode == "en") {
                                            title = viewModel.homeList
                                                .homelist[index].name_en
                                                .trim();
                                          } else if (langCode == "ru") {
                                            title = viewModel.homeList
                                                .homelist[index].name_ru
                                                .trim();
                                          }
                                          return Container(
                                              child: Column(
                                            children: <Widget>[
                                              _titleContainer(title),
                                              Container(
                                                child: ListView.builder(
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: viewModel
                                                        .homeList
                                                        .homelist[index]
                                                        .list
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index2) {
                                                      return Container(
                                                        height: height * 0.5,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.5,
                                                                height: height *
                                                                    0.5,
                                                                child: InkWell(
                                                                    child: Container(
                                                                        child: InkWell(
                                                                  child:
                                                                      GroceryListItemOne(
                                                                    product: viewModel
                                                                        .homeList
                                                                        .homelist[
                                                                            index]
                                                                        .list[index2],
                                                                  ),
                                                                ))))
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                height: height * 0.5,
                                              )
                                            ],
                                          ));
                                        })
                                    : Container(
                                        child: CircularProgressIndicator(),
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 100),
                                      ),
                              ])
                            ],
                          )),
                          onRefresh: _refreshLocal)
                      : RefreshIndicator(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: noInternetConnection(),
                              ),
                            ],
                          ),
                          onRefresh: _refreshLocal,
                        ));
            }),
        onWillPop: () {
          SystemNavigator.pop();
        });
    // TODO: implement build
  }

  Future<Null> _refreshLocal() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => HomePage(
                  fromCheckout: false,
                )),
        (Route<dynamic> route) => false);
    return null;
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
          ],
        ),
      );

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static const platform = const MethodChannel("kendden_shehere/chat_activity");

  _getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
