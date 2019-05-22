import 'package:flutter/material.dart';
import 'package:kendden_shehere/data/model/category_item.dart';
import 'package:kendden_shehere/data/model/list_categories.dart';
import 'package:kendden_shehere/service/networks.dart';

class GroceryCategoriesPage extends StatefulWidget {
  String id,title;

  GroceryCategoriesPage({this.id,this.title});

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
          title: new Text(widget.title),
          backgroundColor: Colors.lightGreen,
        ),
        body: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                child: ListTile(
              leading: new Text(
                categories[index].name_en,
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new GroceryCategoriesPage(
                          id: categories[index].id,title:categories[index].name_en
                        )));
              },
            ));
          },
          itemCount: categories.length,
        ));
  }

  @override
  void initState() {
    super.initState();
    getCategories().then((onvalue) {
      for (int i = 0; i < onvalue.length; i++) {
        if (onvalue[i].parent == widget.id) {
          categories.add(onvalue[i]);
        }
      }
      setState(() {
        categories=categories;
      });
    });
  }

  Future<List<Category>> getCategories() async {
    ListCategories categories = await Networks.listCategories();
    return categories.categories;
  }
}
