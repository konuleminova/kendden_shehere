import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kendden_shehere/data/model/newmodel/new_product_model.dart';
import 'package:kendden_shehere/data/model/newmodel/products_in_category_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem1.dart';


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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  FutureBuilder(
          future: getProductsInCategory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return new CustomScrollView(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 360,
                                  child: InkWell(
                                    child: GroceryListItemOne(
                                      product: snapshot.data[index],
                                    ),
                                  ));
                            }, childCount: snapshot.data.length)))
                  ],
                 // controller: _scrollController,
                );
              }
            }else{
              return new Center(child: new CircularProgressIndicator(),);
            }
          });
  }

  Future<List<NewProduct>> getProductsInCategory() async {
    ProductsInCategory productsInCategory =
        await Networks.productsInCategory(widget.id);
    return productsInCategory.productsInCategory;
  }
}
