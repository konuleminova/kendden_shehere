import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/connectivity/con_enum.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/home/home_viewmodel.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/scale.dart';
import 'package:kendden_shehere/ui/animation/size.dart';
import 'package:kendden_shehere/ui/animation/slide.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/grocery/show_more.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_error_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:kendden_shehere/ui/widgets/drawer.dart';
import 'package:kendden_shehere/ui/widgets/search.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:async/async.dart';

import 'grocery/campaign.dart';
import 'grocery/category_parent.dart';
import 'grocery/grocery_categories.dart';
import 'grocery/grocery_list.dart';

class HomePage extends StatelessWidget {
  List<String> imagesCategory = [
    'images/ks/ct1.png',
    'images/ks/ct2.png',
    'images/ks/ct3.png',
    'images/ks/ct4.png',
    'images/ks/ct5.png',
    'images/ks/ct6.png',
    'images/ks/ct7.png',
    'images/ks/ct8.png',
    'images/ks/ct9.png',
    'images/ks/ct10.png',
    'images/ks/ct11.png',
    'images/ks/ct12.png',
    'images/ks/ct14.png',
    'images/ks/ct13.png',
  ];
  double height = 0;
  double width = 0;
  List<String> bannerPhotos = new List();
  String title;
  AsyncMemoizer memoizer = new AsyncMemoizer();
  HomeViewModel viewModel;
  bool fromCheckout;
  BuildContext context;
  Future _future, _future2;
  List<Category> categorie = new List();
  List<Category> tempCategories = new List();

  HomePage({this.fromCheckout});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //this.context = context;
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return WillPopScope(
        child: new StoreConnector(
            onInit: (store) {
              //_future = Networks().bannerImages();
              // _future2 = Networks().listCategories();
              //_future2 = Networks().userinfo();
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
                            return Material(
                                type: MaterialType.transparency,
                                child: PaymentSuccessDialog(context));
                          });
                    } else {
//                      showDialog(
//                          context: context,
//                          builder: (BuildContext context) {
//                            return PaymentErrorDialog(
//                                context,
//                                "Odeme heyate kecmedi.",
//                                'Xahiş edirik əməliyyatı yenidən təkrarlayasınız.');
//                          });
                    }
                  }
                });
              }
//              categories.clear();
//              getCategories().then((onValue) {
//                if (onValue != null) {
//                  for (int i = 0; i < onValue.length; i++) {
//                    if (onValue[i].parent == '0') {
//                      categories.add(onValue[i]);
//                    }
//                  }
//                  tempCategories.addAll(onValue);
//                }
//              });
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
            converter: (Store<AppState> store) => HomeViewModel.create(store),
            builder: (BuildContext context, HomeViewModel viewModel) {
              return new Scaffold(
                  //key: _scaffold,
                  backgroundColor: greyFixed,
                  appBar: new AppBar(
                    backgroundColor: greenFixed,
                    elevation: 0,
                    leading: Builder(
                      builder: (context) => GestureDetector(
                        child: Image.asset('images/ks/menu.png'),
                        onTap: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    centerTitle: true,
                    title: new Text(AppTranslations.of(context)
                        .text("title_select_language")),
                    actions: <Widget>[
                      GestureDetector(
                          child: Image.asset('images/ks/chat.png'),
                          onTap: () {
                            getNewActivity();
                          }),
                      SizedBox(
                        width: 4,
                      )
                    ],
                  ),
                  floatingActionButton: new FloatingActionButton(
                    backgroundColor: greenFixed,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GroceryShopCartPage(
                                    fromCheckout: false,
                                  )));
                    },
                    child: new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        InkWell(
                            child: new IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: null),
                            onTap: null),
                        viewModel.shopItems.length != 0
                            ? new Positioned(
                                right: 6,
                                top: 6,
                                child: new Container(
                                  padding: EdgeInsets.only(left: 7, right: 7),
                                  decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: greenFixed)),
                                  constraints: BoxConstraints(
                                    minWidth: 14,
                                    minHeight: 14,
                                  ),
                                  child: Text(
                                    viewModel.shopItems.length.toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : new Container()
                      ],
                    ),
                  ),
                  drawer: DrawerWidget(),
                  body: connectionStatus != ConnectivityStatus.Offline
                      ? RefreshIndicator(
                          child: SingleChildScrollView(
                              child: Stack(
                            children: <Widget>[
                              new Wrap(children: <Widget>[
                                Container(
                                    height: 180,
                                    child: Stack(
                                      // alignment: Alignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                color: greenFixed,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                color: greyFixed,
                                                child: ListTile(
                                                    title: Text(
                                                      AppTranslations.of(
                                                              context)
                                                          .text('categories'),
                                                      style: TextStyle(
                                                          color: blackFixed,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    trailing: GestureDetector(
                                                      child: Text(AppTranslations.of(context).text('show_more')),
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            ScaleRoute(
                                                                page:
                                                                    CategoryParentPage()));
//                                                        Navigator.push(
//                                                            context,
//                                                            ScaleRoute(
//                                                                page: new GroceryCategoriesPage(
//                                                                    id: "0",
//                                                                    title: AppTranslations.of(
//                                                                            context)
//                                                                        .text(
//                                                                            "categories"))));
                                                      },
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: ListTile(
                                                title: Text(
                                                AppTranslations.of(context).text('looking_for'),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                leading: IconButton(
                                                  icon: Icon(Icons.search),
                                                  onPressed: null,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            showSearch(
                                                context: context,
                                                delegate: SearchWidget());
                                          },
                                        )
                                      ],
                                    )),
                                AspectRatio(
                                    aspectRatio: 8 / 3,
                                    child: FutureBuilder(
                                      future: Networks().listCategories(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          categorie.clear();
                                          ListCategories categories =
                                              snapshot.data;
                                          if (categories != null) {
                                            for (int i = 0;
                                                i <
                                                    categories
                                                        .categories.length;
                                                i++) {
                                              if (categories
                                                      .categories[i].parent ==
                                                  '0') {
                                                categorie.add(
                                                    categories.categories[i]);
                                              }
                                            }
                                            tempCategories
                                                .addAll(categories.categories);
                                          }

                                          return ListView.builder(
                                              padding: EdgeInsets.all(6.0),
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: categorie.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                String title;
                                                String langCode =
                                                    Localizations.localeOf(
                                                            context)
                                                        .languageCode;
                                                if (langCode == "tr") {
                                                  title = categorie[index]
                                                      .name_az
                                                      .trim();
                                                } else if (langCode == "en") {
                                                  title = categorie[index]
                                                      .name_en
                                                      .trim();
                                                } else if (langCode == "ru") {
                                                  title = categorie[index]
                                                      .name_ru
                                                      .trim();
                                                }
                                                return GestureDetector(
                                                  child: Card(
                                                    elevation: 4,
                                                    margin: EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    color: Colors.white,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                        width: width * 0.28,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Image.asset(
                                                                  imagesCategory[
                                                                      index]),
                                                              flex: 2,
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                      title,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        IconButton(
                                                                      onPressed:
                                                                          null,
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                        color:
                                                                            blackFixed,
                                                                        size:
                                                                            19,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  onTap: () {
                                                    bool isCategory = false;
                                                    for (int i = 0;
                                                        i <
                                                            tempCategories
                                                                .length;
                                                        i++) {
                                                      if (categorie[index].id ==
                                                          tempCategories[i]
                                                              .parent) {
                                                        isCategory = true;
                                                        break;
                                                      } else {
                                                        isCategory = false;
                                                      }
                                                    }
                                                    if (isCategory) {
                                                      Navigator.push(
                                                          context,
                                                          SizeRoute(
                                                              page: new GroceryCategoriesPage(
                                                                  id: categorie[
                                                                          index]
                                                                      .id,
                                                                  title:
                                                                      title)));
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          SizeRoute(
                                                              page:
                                                                  GroceryListPage(
                                                            title: title,
                                                            id: categorie[index]
                                                                .id,
                                                            order: '0',
                                                          )));
                                                    }
                                                  },
                                                );
                                              });
                                        } else {
                                          return Container();
                                        }
                                      },
                                    )),
                                ListTile(
                                    title: Text(
                                      AppTranslations.of(context)
                                          .text('campaigns'),
                                      style: TextStyle(
                                          color: blackFixed,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    trailing: GestureDetector(
                                      child: Text(AppTranslations.of(context)
                                          .text('show_more')),
                                      onTap: () {
                                        Navigator.push(context,
                                            ScaleRoute(page: CampaignsPage()));
                                      },
                                    )),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: _buildCarousel(),
                                ),
                                _buildBody(viewModel),
                                _footer(viewModel)
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
                                child: noData(AppTranslations.of(context)
                                        .text('no_internet') +
                                    AppTranslations.of(context)
                                        .text('try_again')),
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
    if (viewModel != null) {
      viewModel.onFetchAllCollection();
    }
    return null;
  }

  _titleContainer(String title,BuildContext context,List<Product>products) => new Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10, left: 8),
        height: 60,
        color: Colors.grey[200],
        child: new Stack(
          children: <Widget>[
            new Container(
              child: new Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: blackFixed,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            GestureDetector(
              child: Align(alignment: Alignment.centerRight,child: Text(AppTranslations.of(context).text('show_more')),),
              onTap: () {
                Navigator.push(
                    context,
                    ScaleRoute(
                        page:
                      HomeListShowMore(title,products)));
              },
            )
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

  static getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  _buildCarousel() => new SizedBox(
        width: width,
        height: height * 0.23,
        child: new PageView(children: <Widget>[
          new FutureBuilder(
              future: Networks().bannerImages(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  bannerPhotos = snapshot.data;
                  List<Widget> imagesWidget = new List();
                  for (int i = 0; i < bannerPhotos.length - 1; i++) {
                    imagesWidget.add(Card(
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: new Container(
                          width: width * 0.6,
                          child: ClipRRect(
                            child: new Image(
                                image: NetworkImage(
                                  bannerPhotos[i + 1],
                                ),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      elevation: 3,
                    ));
                  }
                  return ListView(
                    children: imagesWidget,
                    scrollDirection: Axis.horizontal,
                  );
                } else {
                  return Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              })
        ]),
      );

  _buildBody(HomeViewModel viewModel) => viewModel.homeList.homelist != null
      ? ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: viewModel.homeList.homelist.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            String langCode = Localizations.localeOf(context).languageCode;
            if (langCode == "tr") {
              title = viewModel.homeList.homelist[index].name_az.trim();
            } else if (langCode == "en") {
              title = viewModel.homeList.homelist[index].name_en.trim();
            } else if (langCode == "ru") {
              title = viewModel.homeList.homelist[index].name_ru.trim();
            }
            return Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    _titleContainer(title,context, viewModel.homeList.homelist[index].list),
                    AspectRatio(
                      child: Container(
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                viewModel.homeList.homelist[index].list.length,
                            itemBuilder: (BuildContext context, int index2) {
                              return Card(
                                margin: EdgeInsets.all(8),
                                elevation: 4,
                                child: Container(
                                  width: width * 0.42,
                                  child: GroceryListItemOne(
                                    product: viewModel
                                        .homeList.homelist[index].list[index2],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              );
                            }),
                      ),
                      aspectRatio: 9 / 6,
                    )
                  ],
                ));
          })
      : Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 100),
        );

  _footer(HomeViewModel viewModel) => viewModel.homeList.homelist != null
      ? Container(
          alignment: Alignment.center,
          color: greenFixed,
          child: ListTile(
            title: Text(
              '© 2019 Agro Trade',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      : SizedBox();

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks().listCategories();
    if (categories != null) {
      return categories.categories;
    } else {
      return null;
    }
  }
}
