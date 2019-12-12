import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/redux/home/home_action.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
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
          store.dispatch(ShowHomeWishAction(store));
          store.dispatch(ShowHomeBasketAction(store));
          //store.state.wishItems.clear();
        },
        converter: (Store<AppState> store) => WishListViewModel.create(store),
        builder: (BuildContext context, WishListViewModel viewModel) {
          this.viewModel = viewModel;
          return new Scaffold(
              appBar: new AppBar(
                centerTitle: true,
                backgroundColor: greenFixed,
                title: Text(AppTranslations.of(context).text("wish_list")),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                      child: viewModel.wishItems.length > 0
                          ? _buildWishListItem(viewModel.wishItems[0])
                          : _emptyWishList()),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ));
        });
  }

  Widget _buildWishListItem(Product wishItem) {
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
        new CustomScrollView(
         // controller: _scrollController,
          slivers: <Widget>[
            SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: new SliverGrid(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        childAspectRatio: 0.62),
                    delegate:
                    new SliverChildBuilderDelegate(
                            (BuildContext context,
                            int index) {
                          return  Card(
                            margin: EdgeInsets.all(8),
                            elevation: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: GroceryListItemOne(
                                product: viewModel.wishItems[index],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          );
                        },
                        childCount: viewModel
                            .wishItems.length)))
          ],
          // controller: _scrollController,
        ),
      ],
    );
  }

//  Widget _shopBody() => new Container(
//        margin: EdgeInsets.only(bottom: 16, top: 16, left: 10, right: 12),
//        child: new CustomScrollView(
//          //shrinkWrap: true,
//         silvers: viewModel.wishItems
//              .map((Product wishItem) => _buildWishListItem(wishItem))
//              .toList(),
//        ),
//      );

  _emptyWishList() => Container(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/ks/heart.png'),
                ListTile(
                  title: Text(
                    AppTranslations.of(context).text('wishlist_empty'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: blackFixed, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    AppTranslations.of(context).text('explore'),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Align(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    color: greenFixed,
                    disabledColor: greenFixed,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                    child: Text(
                    AppTranslations.of(context).text('start_shopping'),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              alignment: AlignmentDirectional(0, 0.5),
            )
          ],
        ),
      );
}
