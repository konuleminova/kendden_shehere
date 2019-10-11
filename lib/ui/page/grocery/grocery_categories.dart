import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/size.dart';
import 'package:kendden_shehere/ui/animation/slide.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_list.dart';
import 'package:kendden_shehere/util/helper_class.dart';

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
  bool hasInternet=false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title.trim()),
              backgroundColor: Colors.lightGreen,
            ),
            body:categories.length > 0
                ?  new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                String title;
                String langCode = Localizations.localeOf(context).languageCode;
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
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withOpacity(0.9)
                          : Colors.white.withOpacity(0.9),
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    // print(categories[index].id);
                    bool isCategory = false;
                    for (int i = 0; i < tempCategories.length; i++) {
                      if (categories[index].id == tempCategories[i].parent) {
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
                          SlideRightRoute(
                              page: GroceryListPage(
                            title: title,
                            id: categories[index].id,
                            order: order,
                          )));
                    }
                  },
                ));
              },
              itemCount: categories.length,
            )
        :loading());
  }

  @override
  void initState() {
    super.initState();
    categories.clear();
    checkInternetConnection().then((onValue) {
      if (onValue) {
        hasInternet=onValue;
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
        });
      }
    });
  }

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks().listCategories();
    if (categories != null) {
      return categories.categories;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    categories.clear();
    tempCategories.clear();
  }
}
