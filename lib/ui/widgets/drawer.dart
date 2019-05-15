import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerState();
  }
}

class DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: new Text(
                  "Name Surname",
                  style: new TextStyle(fontSize: 20),
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
            title: Text("Categories"),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text("WhishList"),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/wish_list");
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text("Order History"),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/order_history");
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("Delivery Terms"),
            onTap: () {
              Navigator.pushNamed(context, '/delivery_terms');
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text("FAG"),
            onTap: () {
              Navigator.pushNamed(context, '/fag');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: () {
              Navigator.pushNamed(context, '/about_us');
            },
          ),
          ListTile(leading: Icon(Icons.phone), title: Text("Contact Us")),
        ],
      ),
    );
  }
}
