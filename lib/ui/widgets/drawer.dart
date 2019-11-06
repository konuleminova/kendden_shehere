import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class DrawerWidget extends StatelessWidget {
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
              new FutureBuilder(
                future: _getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final UriData data =
                        Uri.parse(snapshot.data[1]['img']).data;
                    //print(data.isBase64); // Should print true
                    // print(data.contentAsBytes());
                    // Uint8List bytes =System.Convert.FromBase64String(snapshot.data[1]['img']);
                    // new Image.memory(data.contentAsBytes()),
                    return UserAccountsDrawerHeader(
                      accountName: snapshot.hasData
                          ? new Text(
                              snapshot.data[1]['name'] +
                                  " " +
                                  snapshot.data[1]['surname'],
                              style: new TextStyle(fontSize: 18),
                            )
                          : new Text(
                              name + " " + surname,
                              style: new TextStyle(fontSize: 18),
                            ),
                      accountEmail: new Text(""),
                      currentAccountPicture: CircleAvatar(
                          minRadius: 60,
                          backgroundColor: Colors.green.shade300,
                          child: data != null
                              ? ClipOval(
                                  child: new Image.memory(data.contentAsBytes(),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fill),
                                )
                              : CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage:
                                      AssetImage('images/profile.png'),
                                  backgroundColor: Colors.transparent,
                                )),
                      decoration: new BoxDecoration(color: Colors.lightGreen),
                      onDetailsPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/profile");
                      },
                    );
                  } else {
                    // default show loading while state is waiting
                    return UserAccountsDrawerHeader(
                      accountName: new Text(
                        name + " " + surname,
                        style: new TextStyle(fontSize: 18),
                      ),
                      accountEmail: new Text(""),
                      currentAccountPicture: CircleAvatar(
                          minRadius: 60,
                          backgroundColor: Colors.green.shade300,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage('images/profile.png'),
                            backgroundColor: Colors.transparent,
                          )),
                      decoration: new BoxDecoration(color: Colors.lightGreen),
                      onDetailsPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/profile");
                      },
                    );
                  }
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
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
              Navigator.pop(context);
              Navigator.pushNamed(context, "/wish_list");
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text(AppTranslations.of(context).text("order_history")),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/order_history");
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text(AppTranslations.of(context).text("delivery_terms")),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/delivery_terms");
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(AppTranslations.of(context).text("fag")),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/fag");
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(AppTranslations.of(context).text("about_us")),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/about_us");
            },
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(AppTranslations.of(context).text("contact_us")),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/contacts");
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(AppTranslations.of(context).text("complaints")),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/complaints");
            },
          ),
        ],
      ),
    );
  }

  _getData() {
    name = SharedPrefUtil().name;
    surname = SharedPrefUtil().surname;
    return Networks().userinfo();
  }
}
