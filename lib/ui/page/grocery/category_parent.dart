import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/size.dart';
import 'package:kendden_shehere/ui/page/home.dart';
import 'package:kendden_shehere/util/helper_class.dart';

import 'grocery_categories.dart';
import 'grocery_list.dart';

class CategoryParentPage extends StatelessWidget {
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
  List<Category> categorie = new List();
  List<Category> tempCategories = new List();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenFixed,
          centerTitle: true,
          title: Text(AppTranslations.of(context).text('categories')),
          actions: <Widget>[
            GestureDetector(
                child: Image.asset('images/ks/chat.png'),
                onTap: () {
                  HomePage.getNewActivity();
                }),
            SizedBox(
              width: 4,
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(16),
            child: FutureBuilder(
                future: Networks().listCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    categorie.clear();
                    ListCategories categories = snapshot.data;
                    if (categories != null) {
                      for (int i = 0; i < categories.categories.length; i++) {
                        if (categories.categories[i].parent == '0') {
                          categorie.add(categories.categories[i]);
                        }
                      }
                      tempCategories.addAll(categories.categories);
                    }
                    return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        childAspectRatio: 5 / 6,
                        children:
                            List<Widget>.generate(categorie.length, (index) {
                          String title;
                          String langCode =
                              Localizations.localeOf(context).languageCode;
                          if (langCode == "tr") {
                            title = categorie[index].name_az.trim();
                          } else if (langCode == "en") {
                            title = categorie[index].name_en.trim();
                          } else if (langCode == "ru") {
                            title = categorie[index].name_ru.trim();
                          }
                          return GridTile(
                              child: GestureDetector(
                            child: Card(
                              elevation: 4,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset(imagesCategory[index]),
                                      flex: 2,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              title,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              onPressed: null,
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: blackFixed,
                                                size: 19,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(16),
                              ),
                            ),
                            onTap: () {
                              bool isCategory = false;
                              for (int i = 0; i < tempCategories.length; i++) {
                                if (categorie[index].id ==
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
                                            id: categorie[index].id,
                                            title: title)));
                              } else {
                                Navigator.push(
                                    context,
                                    SizeRoute(
                                        page: GroceryListPage(
                                      title: title,
                                      id: categorie[index].id,
                                      order: '0',
                                    )));
                              }
                            },
                          ));
                        }));
                  } else
                    return loading();
                })));
  }
}
