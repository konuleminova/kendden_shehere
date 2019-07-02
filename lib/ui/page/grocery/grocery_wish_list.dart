import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
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
  List<NewProduct> tempWishItems;
  double width;
  WishListViewModel viewModel;

  var increment = 1;

  @override
  void initState() {
    super.initState();
    wishItems = new List<Product>();
    tempWishItems = new List<NewProduct>();
    // store.state.products[0].status=true;
    // wishItems.clear();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (WishListViewModel viewModel) {
          viewModel.onFetchWishList("179");
        },
        /* onInit: (store) {
          Future<dynamic> response = Networks.wishList("179");
          response.then((onValue) {
            print(onValue.productsInCategory[0].list[0].name_en);
            tempWishItems.addAll(onValue.productsInCategory[0].list);
            print(tempWishItems);
            for (int i = 0; i < tempWishItems.length; i++) {
              wishItems.add(new Product(
                title: tempWishItems[i].name_en,
                subtitle: tempWishItems[i].maininfo_en,
                price: "2 Azn",
                image: "https://kenddenshehere.az/images/pr/th/" +
                    tempWishItems[i].code +
                    ".jpg",
              ));
            }
            print(wishItems);
          });
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
        */
        onWillChange: (WishListViewModel viewModel) {
          tempWishItems.addAll(viewModel.wishItems);
        },
        converter: (Store<AppState> store) => WishListViewModel.create(store),
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
              body: FutureBuilder(
                  future: getWishList("179"),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Expanded(child: _shopBody()),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }));
        });
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          //shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          children: tempWishItems
              .map((NewProduct shopItem) => _buildWishListItem(shopItem))
              .toList(),
        ),
      );

  Widget _buildWishListItem(NewProduct shopItem) => new Stack(
        children: <Widget>[
          GroceryListItemTwo(new Product(
              image: "https://kenddenshehere.az/images/pr/th/" +
                  shopItem.code +
                  ".jpg",
              title: shopItem.name_en,
              subtitle: shopItem.name_en,
              price: shopItem.price,
              isLiked: true,
              isAdded: false,
              amount: 1)),
        ],
      );

  Future<List_Wish_Model> getWishList(id) async {
    List_Wish_Model wishList = await Networks.wishList(id);
    return wishList;
  }
}
