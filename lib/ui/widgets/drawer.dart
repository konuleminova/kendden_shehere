import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/animation/scale.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_categories.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_wish_list.dart';
import 'package:kendden_shehere/ui/page/grocery/order_history.dart';
import 'package:kendden_shehere/ui/page/menu/about_us.dart';
import 'package:kendden_shehere/ui/page/menu/complaints.dart';
import 'package:kendden_shehere/ui/page/menu/contacts.dart';
import 'package:kendden_shehere/ui/page/menu/delivery.dart';
import 'package:kendden_shehere/ui/page/menu/fag.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerWidgetState();
  }
}

class DrawerWidgetState extends State<DrawerWidget> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = Networks().userinfo();
  }

  @override
  void dispose() {
    super.dispose();
    _future = null;
  }

  @override
  Widget build(BuildContext context) {
    AsyncMemoizer memoizer = new AsyncMemoizer();
    // TODO: implement build
    return Container();
  }
}
