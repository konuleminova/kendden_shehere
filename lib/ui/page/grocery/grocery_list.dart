import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/redux/home/home_viewmodel.dart';
import 'package:kendden_shehere/ui/widgets/dropdown.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';
import 'package:kendden_shehere/ui/page/test/old_product_list_item.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class GroceryListPage extends StatefulWidget {
  String title;

  GroceryListPage(this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryListPageState();
  }
}

class GroceryListPageState extends State<GroceryListPage> {
  int page = 0;
  List<Product> productList;
  ScrollController _scrollController;
  String message;
  HomeViewModel viewModel;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListener);
    productList = new List();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        onInitialBuild: (HomeViewModel viewModel) {
          viewModel.onFetchProductList(10, page);
          this.viewModel = viewModel;
        },
        converter: (Store<AppState> store) => HomeViewModel.create(store),
        onInit: (store) {
          store.onChange.listen((onData) {
            if (onData != null) {
              try {
                productList.addAll(onData.products);
              } catch (exceptoon) {}
              // print("//" + onData.campaign.data.toString() + "...");
            }
          });
        },
        builder: (BuildContext context, HomeViewModel viewModel) {
          // TODO: implement build
          return new Scaffold(
              key: scaffoldKey,
              appBar: new AppBar(
                backgroundColor: Colors.lightGreen,
                title: Text("Product List"),
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
                  ),
                ],
              ),
              body: new CustomScrollView(
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
                                height: 350,
                                child: InkWell(
                                  child: GroceryListItemOne(
                                    product: productList[index],
                                    viewModel: viewModel,
                                  ),
                                ));
                          }, childCount: productList.length)))
                ],
                controller: _scrollController,
              ));
        });
  }

  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      print('A-Z');
    } else if (choice == Constants.SecondItem) {
      print('Z-A');
    } else if (choice == Constants.ThirdItem) {
      print('Higher to Lower');
    }
  }

  void loadMore() {
    page++;
    if (viewModel != null) {
      viewModel.onFetchProductList(10, page);
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
        print(message);
        loadMore();
      });
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        message = "reach the top";
        print(message);
      });
    }
  }
}
