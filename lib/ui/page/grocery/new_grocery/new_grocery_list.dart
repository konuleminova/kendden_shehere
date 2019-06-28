import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/categories/products_in_category_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';
import 'package:redux/redux.dart';

class NewGroceryListPage extends StatefulWidget {
  String id;

  NewGroceryListPage({this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryListPageState();
  }
}

class GroceryListPageState extends State<NewGroceryListPage> {
  ScrollController _scrollController;
  int page = 0;
  List<NewProduct> productList;
  ProductListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    productList = new List();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector(
      onInitialBuild: (ProductListViewModel viewModel) {
        this.viewModel = viewModel;
        viewModel.onFetchProductList(widget.id, "10", "0");
      },
      onWillChange: (ProductListViewModel viewModel) {
        productList.addAll(viewModel.productList);
      },
      converter: (Store<AppState> store) => ProductListViewModel.create(store),
      builder: (BuildContext context, ProductListViewModel) {
        return productList != null
            ? new CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: new SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.55),
                          delegate: new SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 360,
                                child: InkWell(
                                  child: GroceryListItemOne(
                                    product: productList[index],
                                  ),
                                ));
                          }, childCount: productList.length)))
                ],
                // controller: _scrollController,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Future<List<NewProduct>> getProductsInCategory(
      String limit, String page) async {
    ProductsInCategory productsInCategory =
        await Networks.productsInCategory(widget.id, "0", "2", limit, page);
    print(productsInCategory.productsInCategory.toString());
    return productsInCategory.productsInCategory;
  }

  void loadMore() {
    page = page + 10;
    print(productList.toString() + "initial");
    viewModel.onFetchProductList(widget.id, "10", page.toString());
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        loadMore();
        print("reach the bottom");
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }
}
