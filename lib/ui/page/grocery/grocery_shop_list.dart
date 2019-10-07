import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/dialog/payment_success_dialog.dart';
import 'package:kendden_shehere/ui/widgets/dialog/profile_edit_dialog.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem3.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';

class GroceryShopCartPage extends StatefulWidget {
  bool fromCheckout = false;

  GroceryShopCartPage({this.fromCheckout});

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
  ScrollController _scrollController;

  bool _end=false;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();

    _scrollController.addListener(
            () {
          double maxScroll = _scrollController.position.maxScrollExtent;
          double currentScroll = _scrollController.position.pixels;
          double delta = 200.0; // or something else..
          if ( maxScroll - currentScroll <= delta) { // whatever you determine here
            //.. load more


          }
        }
    );
  }

  @override
  void dispose() {
    widget.fromCheckout = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (ShoppingCartViewModel  viewModel) {
          this.viewModel=viewModel;
          viewModel.onFetchShopList();

        },
        onWillChange: (ShoppingCartViewModel  viewModel) {
          //tempWishItems.addAll(viewModel.wishItems);
        },
        converter: (Store<AppState> store) => ShoppingCartViewModel .create(store),
        builder: (BuildContext context,ShoppingCartViewModel  viewModel) {
          products=viewModel.shopItems;
          this.viewModel = viewModel;
          return  WillPopScope(
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.lightGreen,
              title: new Text("Shopping List"),
              leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
                Navigator.pop(context);
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },),
            ),
            body: FutureBuilder(
                future: Networks.basket(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != "500") {
                      OrderHistoryListModel order = snapshot.data;
//                print("konul!!");
//                print(order.orderList[0].list);
                     // products = order.orderList[0].list.productsInCategory;

                      //   products[0].id;
                      return Column(
                        children: <Widget>[
                          Expanded(child: _shopBody()),
//                          SizedBox(
//                            height: 10.0,
//                          ),
                          // _buildTotals();
                          _buildTotals(
                            order.orderList[0].delivery_price,
                            order.orderList[0].bprice,
                          )
                        ],
                      );
                    } else {
                      if (widget.fromCheckout) {
                        Future.delayed(
                            Duration.zero,
                            () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return PaymentSuccessDialog(context);
                                }));
                      }
                      return Container();
                    }
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                })),
        onWillPop: () {
         // Navigator.pushReplacementNamed(context, "/home");
          Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
        });});
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 0, top: 16, left: 10, right: 12),
        child:NotificationListener(child:  new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children:products
              .map(
                (NewProduct shopItem) => NewGroceryListItemThree(shopItem,viewModel),
          )
              .toList(),
        ),onNotification: (t){
          if(t is ScrollStartNotification){
            setState(() {
              _end=true;
            });
          }else if(t is ScrollEndNotification){
            setState(() {
              _end=false;
            });
          }
        },)
      );

  Widget _buildTotals(String delivery, String subtotal) {
    // double total = double.parse(delivery) + double.parse(subtotal);
    return !_end?ClipOval(
      clipper: OvalTopBorderClipper(),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                color: Colors.black,
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
                Text("" + " AZN"),
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
    ):Container();
  }

//  Widget _builShopListItem(NewProduct shopItem) => new Stack(
//        children: <Widget>[
//          NewGroceryListItemTwo(shopItem),
//          Positioned(
//            top: 5,
//            right: 0,
//            child: Container(
//              height: 30,
//              width: 30,
//              alignment: Alignment.topRight,
//              child: MaterialButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(5.0)),
//                padding: EdgeInsets.all(0.0),
//                color: Colors.pinkAccent,
//                child: Icon(
//                  Icons.clear,
//                  color: Colors.white,
//                ),
//                onPressed: () {
//                  //return viewModel.removeShopItem(shopItem);
//                  // print(viewModel.shopItems.toString());
//                },
//              ),
//            ),
//          ),
//        ],
//      );
//
//  void _checkAlertDialog() async {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return ProfileEditDialog("mobile");
//        });
//  }
}
