import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerState();
  }
}

class DrawerState extends State<DrawerWidget> {
  String name;
  String surname;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: new FutureBuilder(
                  future: _getUserInfo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return new Text(
                       snapshot.data,
                        style: new TextStyle(fontSize: 20),
                      );
                    } else {
                      // default show loading while state is waiting
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                accountEmail: new Text("300 Bonus"),
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
                  new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new GroceryCategoriesPage(
                          id: "0",
                          title: AppTranslations.of(context)
                              .text("categories"))));
              // Navigator.pushNamed(context, "/categories");
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text(AppTranslations.of(context).text("wish_list")),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/wish_list");
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.history),
              title:  Text(AppTranslations.of(context).text("order_history")),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/order_history");
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title:  Text(AppTranslations.of(context).text("notifications")),
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title:  Text(AppTranslations.of(context).text("delivery_terms")),
            onTap: () {
              Navigator.pushNamed(context, '/delivery_terms');
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(AppTranslations.of(context).text("fag")),
            onTap: () {
              Navigator.pushNamed(context, '/fag');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title:  Text(AppTranslations.of(context).text("about_us")),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          ListTile(leading: Icon(Icons.phone), title: Text(AppTranslations.of(context).text("contact_us")),),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _getUserInfo() async {
    name = await SharedPrefUtil().getString(SharedPrefUtil.name);
    surname = await SharedPrefUtil().getString(SharedPrefUtil.surname);
    return name+" "+ surname;
  }
}
