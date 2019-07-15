import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/productlist_viewmodel.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';
import 'package:redux/redux.dart';

class NewGroceryListPage extends StatefulWidget {
  String title;
  String id;
  String order;

  NewGroceryListPage({this.title, this.id, this.order});

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
  List<NewProduct> productListTemp;
  ProductListViewModel viewModel;
  String order;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    productList = new List();
    productListTemp = new List();
    order = widget.order;
    init();
  }

  @override
  Widget build(BuildContext context) {
   return StoreConnector(
        onInitialBuild: (ProductListViewModel viewModel) {
          this.viewModel = viewModel;
          viewModel.onFetchProductList(widget.id, "10", page.toString(), order);
        },
        onWillChange: (ProductListViewModel viewModel) {
          productList.addAll(viewModel.productList);
        },
        converter: (Store<AppState> store) =>
            ProductListViewModel.create(store),
        builder: (BuildContext context, ProductListViewModel) {
          return new Scaffold(
              appBar: new AppBar(
                title: new Text(widget.title),
                backgroundColor: Colors.lightGreen,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  )
                ],
              ),
              body: productList.length>0
                  ?  new CustomScrollView(
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
                                          childAspectRatio: 0.5),
                                  delegate: new SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 370,
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
                    ));
        });
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      print("choice ACTION>>");
      setState(() {
        productList.clear();
        order = "1";
        page = 0;
        getData().then((onvalue) {
           productList.addAll(onvalue);
        });
      });
      //viewModel.changeOrder("1");
    } else if (choice == Constants.SecondItem) {
      //viewModel.changeOrder("2");
      productList.clear();
      setState(() {
        order = "2";
        page = 0;
        init();
      });
      print("choice ACTION>>");
      //  order = "2";
    } else if (choice == Constants.ThirdItem) {
      productList.clear();
      setState(() {
        order = "3";
        page = 0;
        init();
      });
      // viewModel.changeOrder("3");
    } else {
      productList.clear();
      setState(() {
        order = "4";
        page = 0;
        init();
      });
      // viewModel.changeOrder("4");
    }
  }

  void loadMore() async {
    page = page + 10;
    print(productList.toString() + "initial");
    viewModel.onFetchProductList(
     widget.id, "10", page.toString(), widget.order);
   // init();
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

  init() {
    getData().then((onvalue) {
     // productList.addAll(onvalue);
      // productList.addAll(onvalue);
    });
  }

  Future<List<NewProduct>> getData() async {
    ProductsInCategory response = await Networks.productsInCategory(
        widget.id, order, "0", "10", page.toString());
    if (response != null) {
      // productList.clear();
      productListTemp.clear();
      productListTemp.addAll(response.productsInCategory);
      return productListTemp;
    } else {
      return [];
    }
  }
}
