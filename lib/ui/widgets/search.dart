import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_details_page.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_list.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:redux/redux.dart';

class SearchWidget extends SearchDelegate<String> {
  ScrollController _scrollController;
  int page = 0;
  List<Product> productList = new List();
  List<Product> suggesstionList = new List();
  ProductListViewModel viewModel;
  String lang;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
    }
    // print(products.productsInCategory);
    // TODO: implement buildResults
    // TODO: implement build
    return StoreConnector(
        onInit: (store) {
          _scrollController = new ScrollController();
          _scrollController.addListener(_scrollListener);
        },
        onInitialBuild: (ProductListViewModel viewModel) {
          this.viewModel = viewModel;
          viewModel.onSearchProductList(lang, query);
        },
        onDispose: (store) {
          store.state.newProducts.clear();
        },
        converter: (Store<AppState> store) =>
            ProductListViewModel.create(store),
        builder: (BuildContext context, ProductListViewModel viewModel) {
          return viewModel.productList.length > 0
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
                                delegate: new SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 370,
                                      child: InkWell(
                                        child: GroceryListItemOne(
                                          product: viewModel.productList[index],
                                        ),
                                      ));
                                }, childCount: viewModel.productList.length)))
                      ],
                      // controller: _scrollController,
                    ),
                  ],
                )
              : Center(
                  child: viewModel.productList.length > 0
                      ? CircularProgressIndicator()
                      : Text("Product is not found."),
                );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      lang = "0";
    } else if (langCode == "en") {
      lang = "2";
    } else if (langCode == "ru") {
      lang = "1";
    }
    // TODO: implement buildSuggestions
    return FutureBuilder(
        future: Networks().qsearch(lang, query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String title;
            ProductsInCategory qSearch = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                //  QSearchModel qSearchModel = qSearch.qsearchList[index];
                if (snapshot.data.productsInCategory[index].name_en != null) {
                  if (lang == "0") {
                    title =
                        snapshot.data.productsInCategory[index].name_az.trim();
                  } else if (lang == "1") {
                    title =
                        snapshot.data.productsInCategory[index].name_ru.trim();
                  } else if (lang == "2") {
                    title =
                        snapshot.data.productsInCategory[index].name_en.trim();
                  }
                }

                return ListTile(
                    onTap: () {
                      // print(qSearch.qsearchList);
                      if (snapshot.data.productsInCategory[index].catid !=
                          null) {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new GroceryListPage(
                                      id: qSearch
                                          .productsInCategory[index].catid,
                                      title: qSearch
                                          .productsInCategory[index].name,
                                    )));
                      }
                      if (qSearch.productsInCategory[index].catIdParent !=
                              null &&
                          qSearch.productsInCategory[index].catid == null) {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new GroceryCategoriesPage(
                                      id: qSearch.productsInCategory[index]
                                          .catIdParent,
                                      title: qSearch
                                          .productsInCategory[index].name,
                                    )));
                      }
                      if (qSearch.productsInCategory[index].catIdParent ==
                              null &&
                          qSearch.productsInCategory[index].catid == null) {
                        print("DETAILS");
                        Route route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                GroceryDetailsPage(
                                    qSearch.productsInCategory[index]));
                        Navigator.push(context, route);
                      }
                      //CategoriesIndex if(cat-id!=null,!contains("-"'),//GroceryListPage cat-id!=null&contains(" -") ,//GroceriesDetailsPage if(cat-id==null)
                    },
                    title: new Text(
                        snapshot.data.productsInCategory[index].name_en != null
                            ? title
                            : snapshot.data.productsInCategory[index].name));
              },
              itemCount: snapshot.data.productsInCategory.length,
            );
          } else {
            return Center();
          }
        });
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: Colors.lightGreen,
        primaryIconTheme: theme.primaryIconTheme);
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
     // loadMore();
//      setState(() {
//
//        print("reach the bottom");
//      });
    }
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
//      setState(() {
//        print("reach the top");
//      });
    }
  }
}
