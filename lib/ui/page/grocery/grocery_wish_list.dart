import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_model.dart';
import 'package:kendden_shehere/redux/shoplist/shop_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/oval_tap.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem2.dart';

class GroceryWishListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryWishListPageState();
  }
}

class GroceryWishListPageState extends State<GroceryWishListPage> {
  List<Product> wishItems;
  double width;
  WishListViewModel viewModel;

  var increment = 1;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (WishListViewModel viewModel) {},
        onInit: (store) {
          wishItems = new List<Product>();
          // store.state.products[0].status=true;
          // wishItems.clear();
          for (int i = 0; i < store.state.wishItems.length; i++) {
              wishItems.add(new Product(
                title: store.state.wishItems[i].title,
                subtitle:store.state.wishItems[i].subtitle,
                price: "2 Azn",
                image: store.state.wishItems[i].image,
              ));
          }
          /*if(store.state.products[0].status){
            wishItems.add(new ShopItem(
                title: store.state.products[0].title,
                description: "Dummy Text",
                price: "2 Azn"));
          }
          */
          //store.state.shopItems.clear();
       //   store.state.shopItems.addAll(wishItems);
          //this.wishItems=store.state.wishItems;
        },
        converter: (Store<AppState> store) =>
            WishListViewModel.create(store),
        builder: (BuildContext context, WishListViewModel viewModel) {
          this.viewModel = viewModel;
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.lightGreen,
              title: new Text("Wish List"),
              actions: <Widget>[
                new Container(
                  child: new Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 16),
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                Expanded(child: _shopBody()),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          );
        });
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: viewModel.wishItems
              .map((Product shopItem) => _buildWishListItem(shopItem))
              .toList(),
        ),
      );

  Widget _buildWishListItem(Product shopItem) => new Stack(
        children: <Widget>[
          GroceryListItemTwo(new Product(
              image: shopItem.image,
              title: shopItem.title,
              subtitle: shopItem.subtitle,
              price: shopItem.price,
              isLiked: true,
              isAdded: false,
              amount: 1)),
        ],
      );
}
