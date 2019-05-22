import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/category_item.dart';
import 'package:kendden_shehere/data/model/list_categories.dart';
import 'package:kendden_shehere/service/networks.dart';

class GroceryCategoriesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryCategoriesState();
  }
}

class GroceryCategoriesState extends State<GroceryCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    List<Category> categories = new List();
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Categories"),
        backgroundColor: Colors.lightGreen,
      ),
      body: new Container(
        child: new FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            if (snapShot.hasData) {
              if (snapShot.data != null) {
                for (int i = 0; i < snapShot.data.length; i++) {
                  if (snapShot.data[i].parent == "0") {
                    categories.add(snapShot.data[i]);
                  }
                }

                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      margin: EdgeInsets.only(left: 16,right: 16,top: 10),
                      child: new Text(
                        categories[index].name_en,
                        style:
                            TextStyle(color: Colors.lightGreen, fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  itemCount: categories.length,
                );
              }
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          },
          future: getCategories(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks.listCategories();
    return categories.categories;
  }
}
