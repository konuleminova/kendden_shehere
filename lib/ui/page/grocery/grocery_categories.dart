import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/category_viewmodel.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/scale.dart';
import 'package:kendden_shehere/ui/animation/size.dart';
import 'package:kendden_shehere/ui/animation/slide.dart';
import 'package:kendden_shehere/ui/animation/slide_left.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_list.dart';
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
  List<Category> tempCategories = new List();
  String order = "0";
  CategoryViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector(
        onInitialBuild: (CategoryViewModel viewModel) {
          this.viewModel = viewModel;
          // viewModel.onFetchCategories(widget.id);
        },
        converter: (Store<AppState> store) => CategoryViewModel.create(store),
        builder: (BuildContext context, CategoryViewModel viewModel) {
          if (categories.length > 0) {
            return new Scaffold(
                appBar: new AppBar(
                  title: new Text(widget.title.trim()),
                  backgroundColor: Colors.lightGreen,
                ),
                body: new ListView.builder(
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
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black.withOpacity(0.9)
                                  : Colors.white.withOpacity(0.9),
                          fontSize: 18.0,
                        ),
                      ),
                      onTap: () {
                        // print(categories[index].id);
                        bool isCategory = false;
                        for (int i = 0; i < tempCategories.length; i++) {
                          if (categories[index].id ==
                              tempCategories[i].parent) {
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
                                      id: categories[index].id, title: title)));
                        } else {
                          Navigator.push(
                              context,
                              SlideRightRoute(page:GroceryListPage(
                              title: title,
                              id: categories[index].id,
                              order: order,
                          )));
                        }
                      },
                    ));
                  },
                  itemCount: categories.length,
                ));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(color: Colors.grey[100]),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    categories.clear();
    if (getCategories() != null) {
      getCategories().then((onValue) {
        if (onValue != null) {
          for (int i = 0; i < onValue.length; i++) {
            if (onValue[i].parent == widget.id) {
              setState(() {
                categories.add(onValue[i]);
              });
            }
          }
          tempCategories.addAll(onValue);
        }
        /* if (categories.length <= 0) {
          Route route = MaterialPageRoute(
              builder: (BuildContext context) => NewGroceryListPage(
                    title: widget.title,
                    id: widget.id,
                    order: order,
                  ));
          Navigator.pushReplacement(context, route);
        }
        */
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks().listCategories();
    if (categories != null) {
      return categories.categories;
    } else {
      return null;
    }
  }
}
