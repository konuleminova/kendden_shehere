import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem3.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem2.dart';

class GroceryShopCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryCartState();
  }
}

class GroceryCartState extends State<GroceryShopCartPage> {
  List<Product> shopItems;
  double width;
  ShoppingCartViewModel viewModel;

  var increment = 1;
  List<NewProduct> products = new List();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightGreen,
          title: new Text("Shopping List"),
        ),
        body: FutureBuilder(
            future: Networks.basket("179"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                OrderHistoryListModel order = snapshot.data;
//                print("konul!!");
//                print(order.orderList[0].list);
                products = order.orderList[0].list.productsInCategory;
                return Column(
                  children: <Widget>[
                    Expanded(child: _shopBody()),
                    SizedBox(
                      height: 10.0,
                    ),
                    // _buildTotals();
                    _buildTotals(
                      order.orderList[0].delivery_price,
                      order.orderList[0].bprice,
                    )
                  ],
                );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }));
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: products
              .map(
                (NewProduct shopItem) => NewGroceryListItemThree(shopItem),
              )
              .toList(),
        ),
      );

  Widget _buildTotals(String delivery, String subtotal) {
    double total = double.parse(delivery) + double.parse(subtotal);
    return ClipOval(
      clipper: OvalTopBorderClipper(),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.grey.shade700,
                spreadRadius: 80.0),
          ],
          color: Colors.white,
        ),
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subtotal"),
                Text(subtotal + " AZN"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Delivery fee"),
                Text(delivery + " AZN"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total"),
                Text(total.toString() + " AZN"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, "/checkout");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Checkout", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _builShopListItem(NewProduct shopItem) => new Stack(
        children: <Widget>[
          NewGroceryListItemTwo(shopItem),
          Positioned(
            top: 5,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.topRight,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.all(0.0),
                color: Colors.pinkAccent,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  //return viewModel.removeShopItem(shopItem);
                 // print(viewModel.shopItems.toString());
                },
              ),
            ),
          ),
        ],
      );
}
