import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
class GroceryWishListPage extends StatelessWidget {
  WishListViewModel viewModel;
  String title;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return new StoreConnector(
        onInitialBuild: (WishListViewModel viewModel) {
          viewModel.onFetchWishList();
        },
        onDispose: (store) {
          //store.state.wishItems.clear();
        },
        converter: (Store<AppState> store) => WishListViewModel.create(store),
        builder: (BuildContext context, WishListViewModel viewModel) {
          this.viewModel = viewModel;
          return new Scaffold(
              appBar: new AppBar(
                backgroundColor: Colors.lightGreen,
                title: Text(AppTranslations.of(context).text("wish_list")),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(child: _shopBody()),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ));
        });
  }

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
        NewGroceryListItemTwo(
          product: wishItem,
          viewModel: viewModel,
        ),
      ],
    );
  }

  Widget _shopBody() => new Container(
        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
        child: new ListView(
          children: viewModel.wishItems
              .map((NewProduct wishItem) => _buildWishListItem(wishItem))
              .toList(),
        ),
      );
}
