import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/scale.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_wish_list.dart';
import 'package:kendden_shehere/ui/page/grocery/order_history.dart';
import 'package:kendden_shehere/ui/page/menu/about_us.dart';
import 'package:kendden_shehere/ui/page/menu/contacts.dart';
import 'package:kendden_shehere/ui/page/menu/delivery.dart';
import 'package:kendden_shehere/ui/page/menu/fag.dart';


class DrawerWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    AsyncMemoizer memoizer = new AsyncMemoizer();
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: new FutureBuilder(
                  future: memoizer.runOnce(() {
                    return Networks().userinfo();
                  }),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return new Text(
                        snapshot.data[1]['name'] +
                            " " +
                            snapshot.data[1]['surname'],
                        style: new TextStyle(fontSize: 18),
                      );
                    } else {
                      // default show loading while state is waiting
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                accountEmail: new Text(""),
                currentAccountPicture: CircleAvatar(
                    minRadius: 60,
                    backgroundColor: Colors.green.shade300,
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://content-static.upwork.com/uploads/2014/10/01073427/profilephoto1.jpg'),
                      backgroundColor: Colors.transparent,
                    )),
                decoration: new BoxDecoration(color: Colors.lightGreen),
                onDetailsPressed: () {
                  Navigator.pushNamed<dynamic>(context, "/profile")
                      .then((isLoggedOut) {
                    if (isLoggedOut != null && isLoggedOut == true) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  });
                },
              ),
              Container(
                child: new IconButton(
                  icon: new Icon(Icons.settings),
                  onPressed: () {
                    Navigator.pushNamed(context, "/settings");
                  },
                  iconSize: 25,
                  disabledColor: Colors.white,
                  color: Colors.white,
                ),
                alignment: Alignment.topRight,
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(AppTranslations.of(context).text("categories")),
            onTap: () {
              Navigator.push(
                  context,
                 ScaleRoute(
                      page: new GroceryCategoriesPage(
                          id: "0",
                          title:
                              AppTranslations.of(context).text("categories"))));
              // Navigator.pushNamed(context, "/categories");
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(AppTranslations.of(context).text("wish_list")),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page: GroceryWishListPage()));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text(AppTranslations.of(context).text("order_history")),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page:OrderHistoryPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text(AppTranslations.of(context).text("delivery_terms")),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page: DeliveryPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(AppTranslations.of(context).text("fag")),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page: FagPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(AppTranslations.of(context).text("about_us")),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page: AboutUsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(AppTranslations.of(context).text("contact_us")),
            onTap: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                      page: ContactsPage()));
            },
          ),
        ],
      ),
    );
  }
}
