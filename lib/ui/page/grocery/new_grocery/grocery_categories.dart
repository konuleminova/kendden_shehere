import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/new_grocery/new_grocery_list.dart';
import 'package:redux/redux.dart';

class GroceryCategoriesPage extends StatefulWidget {
  String id, title;

  GroceryCategoriesPage({this.id, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryCategoriesState();
  }
}

class GroceryCategoriesState extends State<GroceryCategoriesPage> {
  List<Category> categories = new List();
  String order = "0";
  ProductListViewModel viewModel;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return StoreConnector(
      onInitialBuild: (ProductListViewModel viewModel) {
        this.viewModel = viewModel;
        // viewModel.onFetchProductList(widget.id, "10", "0",widget.order);
      },
      onWillChange: (ProductListViewModel viewModel) {
        // productList.addAll(viewModel.productList);
      },
      converter: (Store<AppState> store) => ProductListViewModel.create(store),
      builder: (BuildContext context, ProductListViewModel) {
        return new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title.trim()),
              backgroundColor: Colors.lightGreen,
              actions: <Widget>[
                categories.length > 0
                    ? SizedBox(
                        width: 0.0,
                        height: 0.0,
                      )
                    : PopupMenuButton<String>(
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return Constants.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      )
              ],
            ),
            body: FutureBuilder(
                future: getCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  categories.clear();
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (snapshot.data[i].parent == widget.id) {
                          categories.add(snapshot.data[i]);
                        }
                      }
                      if (categories.length > 0) {
                        return new ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            String title;
                            String langCode =
                                Localizations.localeOf(context).languageCode;
                            if (langCode == "tr") {
                              title = categories[index].name_az.trim();
                            } else if (langCode == "en") {
                              title = categories[index].name_en.trim();
                            } else if (langCode == "ru") {
                              title = categories[index].name_ru.trim();
                            }
                            return new Container(
                                child: ListTile(
                              leading: new Text(
                                title,
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black.withOpacity(0.9)
                                      : Colors.white.withOpacity(0.9),
                                  fontSize: 18.0,
                                ),
                              ),
                              onTap: () {
                                print(categories[index].id);
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new GroceryCategoriesPage(
                                                id: categories[index].id,
                                                title: title)));
                              },
                            ));
                          },
                          itemCount: categories.length,
                        );
                      } else {
                        return new NewGroceryListPage(
                          id: widget.id,
                          order: viewModel.order,
                        );
                      }
                    }
                  } else {
                    return Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                }));
      },
    );
  }

  void choiceAction(String choice) {
      if (choice == Constants.FirstItem) {
        order = "1";
        print("choice ACTION>>");
        viewModel.changeOrder("1");
      } else if (choice == Constants.SecondItem) {
        order = "2";
        viewModel.changeOrder("2");
        print("choice ACTION>>");
        //  order = "2";
      } else if (choice == Constants.ThirdItem) {
        order = "3";
        viewModel.changeOrder("3");
      } else {
        order = "4";
        viewModel.changeOrder("4");
      }
  }

  @override
  void initState() {
    super.initState();
    categories.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks.listCategories();
    return categories.categories;
  }
}
