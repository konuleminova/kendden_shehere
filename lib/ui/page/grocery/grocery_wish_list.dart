import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/test/shop_item_model.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';

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
  String title, description;

  var increment = 1;

  @override
  void initState() {
    super.initState();
    wishItems = new List<Product>();
    tempWishItems = new List<NewProduct>();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (WishListViewModel viewModel) {
          viewModel.onFetchWishList();
        },
        onWillChange: (WishListViewModel viewModel) {
          tempWishItems.addAll(viewModel.wishItems);
        },
        converter: (Store<AppState> store) => WishListViewModel.create(store),
        builder: (BuildContext context, WishListViewModel viewModel) {
          this.viewModel = viewModel;
          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.lightGreen,
                title: Text(AppTranslations.of(context).text("wish_list")),
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
              .map((NewProduct wishItem) => _buildWishListItem(wishItem))
              .toList(),
        ),
      );

  Widget _buildWishListItem(NewProduct wishItem) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = wishItem.name_az.trim();
    } else if (langCode == "en") {
      title = wishItem.name_en.trim();
    } else if (langCode == "ru") {
      title = wishItem.name_ru.trim();
    }
    return new Stack(
      children: <Widget>[
        NewGroceryListItemTwo(wishItem),
      ],
    );
  }

  Future<List_Wish_Model> getWishList(id) async {
    List_Wish_Model wishList = await Networks.wishList(id);
    return wishList;
  }
}
