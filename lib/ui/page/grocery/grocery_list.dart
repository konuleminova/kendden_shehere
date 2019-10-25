import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:kendden_shehere/util/helper_class.dart';
import 'package:redux/redux.dart';

import 'grocery_shop_list.dart';

class GroceryListPage extends StatelessWidget {
  ScrollController _scrollController = new ScrollController();
  int page = 0;
  ProductListViewModel viewModel;
  String title;
  String id;
  String order;

  GroceryListPage({this.title, this.id, this.order});

  String lang;
  Store<AppState> _store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        onInit: (store) {
          store.state.isLoading=true;
          _store = store;
          _scrollController = new ScrollController();
          _scrollController.addListener(_scrollListener);
          String langCode = Localizations.localeOf(context).languageCode;
          if (langCode == "tr") {
            lang = "0";
          } else if (langCode == "en") {
            lang = "2";
          } else if (langCode == "ru") {
            lang = "1";
          }
        },
        onDidChange: (ProductListViewModel viewModel){
          viewModel.isLoading=false;
        },
        onInitialBuild: (ProductListViewModel viewModel) {
          this.viewModel = viewModel;
          //viewModel.isLoading=true;
          fetchProductList();
        },
        onDispose: (store) {
          store.state.newProducts.clear();
          store.state.isScrolling = false;
        },
        converter: (Store<AppState> store) =>
            ProductListViewModel.create(store),
        builder: (BuildContext context, ProductListViewModel viewModel) {
          return new Scaffold(
              appBar: new AppBar(
                title: new Text(title),
                backgroundColor: Colors.lightGreen,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
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
                                  builder: (_) => GroceryShopCartPage(
                                        fromCheckout: false,
                                      )));
                        },
                      ),
                      _store.state.shopItems.length != 0
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
                                  _store.state.shopItems.length.toString(),
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
              body: !viewModel.isLoading
                  ? (viewModel.productList.length > 0
                      ? new Stack(
                          children: <Widget>[
                            new CustomScrollView(
                              controller: _scrollController,
                              slivers: <Widget>[
                                SliverPadding(
                                    padding: const EdgeInsets.all(8),
                                    sliver: new SliverGrid(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 1,
                                                mainAxisSpacing: 1,
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.5),
                                        delegate:
                                            new SliverChildBuilderDelegate(
                                                (BuildContext context,
                                                    int index) {
                                          return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              height: 370,
                                              child: InkWell(
                                                child: GroceryListItemOne(
                                                  product: viewModel
                                                      .productList[index],
                                                ),
                                              ));
                                        },
                                                childCount: viewModel
                                                    .productList.length)))
                              ],
                              // controller: _scrollController,
                            ),
                            viewModel.isScrolling &&
                                    viewModel.productList.length > 0
                                ? new Container(
                                    child: CircularProgressIndicator(),
                                    alignment: Alignment.bottomCenter,
                                  )
                                : SizedBox(
                                    height: 0.0,
                                    width: 0.0,
                                  )
                          ],
                        )
                      : Center(
                          child: Text("Product is not found.")
                        ))
                  : loading());
        });
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      order = "1";
      page = 0;
      fetchProductList();
    } else if (choice == Constants.SecondItem) {
      order = "2";
      page = 0;
      fetchProductList();
    } else if (choice == Constants.ThirdItem) {
      order = "3";
      page = 0;
      fetchProductList();
    } else {
      order = "4";
      page = 0;
      fetchProductList();
    }
  }

  void loadMore() async {
    page = page + 10;
    loadm();
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      loadMore();
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  void fetchProductList() {
    viewModel.onFetchProductList(id, lang, "10", page.toString(), order);
  }

  void loadm() {
    viewModel.onLoadMoreProductList(id, lang, "10", page.toString(), order);
  }
}
