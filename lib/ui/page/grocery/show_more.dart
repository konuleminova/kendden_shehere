import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem1.dart';

class HomeListShowMore extends StatelessWidget {
  String title;
  List<Product> products;

  HomeListShowMore(this.title, this.products);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: greyFixed,
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: greenFixed,
      ),
      body: new Stack(
        children: <Widget>[
          new CustomScrollView(
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
                            return Card(
                              margin: EdgeInsets.all(8),
                              elevation: 4,
                              child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.42,
                                child: GroceryListItemOne(
                                  product: products[index],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
                            );
                          },
                          childCount: products.length)))
            ],
          )
        ],
      ),
    );
  }
}
