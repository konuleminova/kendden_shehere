import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/new_grocery/new_grocery_list.dart';

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title.trim()),
          backgroundColor: Colors.lightGreen,
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
                    return new NewGroceryListPage(id: widget.id);
                  }
                }
              } else {
                return Center(
                  child: new CircularProgressIndicator(),
                );
              }
            }));
  }

  @override
  void initState() {
    super.initState();
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
