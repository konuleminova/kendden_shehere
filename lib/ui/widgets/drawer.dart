import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_shop_list.dart';
import 'package:kendden_shehere/ui/page/menu/profile.dart';

class DrawerWidget extends StatelessWidget {
  String name;
  String surname;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
        child: Container(
      color: greenFixed,
      alignment: AlignmentDirectional.center,
      child: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
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
          //DrawerHeader(child: Container()),
          Container(height: MediaQuery.of(context).size.height*0.11,),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            title: Text(
              AppTranslations.of(context).text('profile'),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage()));
              // Navigator.pushNamed(context, "/categories");
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30),
            child: Divider(
              color: Colors.white,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                "/wish_list",
              );
            },
            title: Text(
              AppTranslations.of(context).text(
                "wish_list",
              ),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => GroceryShopCartPage(
                            fromCheckout: false,
                          )));
            },
            title: Text(
              AppTranslations.of(context).text('my_cart'),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          Theme(
              child: ExpansionTile(
                onExpansionChanged: (isExpanded) {
                  this.isExpanded = isExpanded;
                },
                backgroundColor: greenFixed,
                trailing: SizedBox(),
                title: ListTile(
                    contentPadding: EdgeInsets.only(left: 12.0),
                    title: Text(AppTranslations.of(context).text('support'),
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: null),
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 50.0),
                    title: Text(
                      AppTranslations.of(context).text("delivery_terms"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/delivery_terms");
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 30.0),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 50.0),
                    title: Text(AppTranslations.of(context).text("fag"),
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/fag");
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 30.0),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 50.0),
                    title: Text(
                      AppTranslations.of(context).text("contact_us"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/contacts");
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 30.0),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 50.0),
                    title: Text(
                      AppTranslations.of(context).text("complaints"),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/complaints");
                    },
                  ),
                ],
              ),
              data: Theme.of(context).copyWith(dividerColor: greenFixed)),
          isExpanded
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30.0),
            title: Text(
              AppTranslations.of(context).text("about_us"),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/about_us");
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Image.asset('images/ks/ks.png'),
          ),
          SizedBox(height: 30,),
        ],
      ),
    ));
  }
//
//  _getData() {
//    name = SharedPrefUtil().name;
//    surname = SharedPrefUtil().surname;
//    return Networks().userinfo();
//  }
}
