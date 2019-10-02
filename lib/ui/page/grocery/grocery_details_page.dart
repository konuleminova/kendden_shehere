import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/service/networks.dart';
import 'package:kendden_shehere/ui/page/grocery/grocery_big_image.dart';
import 'package:kendden_shehere/ui/widgets/list_item/new_list_item/new_glistitem2.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:share/share.dart';

//import 'package:zoomable_image/zoomable_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class GroceryDetailsPage extends StatefulWidget {
  NewProduct product;

  GroceryDetailsPage(this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryDetailsState();
  }
}

class GroceryDetailsState extends State<GroceryDetailsPage> {
  bool isAdded = false, isLiked = false;
  var amount = 1;
  String title, description;
  NewProduct product;
  String img;

  @override
  Widget build(BuildContext context) {
    String langCode = Localizations.localeOf(context).languageCode;
    if (langCode == "tr") {
      title = product.name_az.trim();
      description = product.maininfo_az.trim();
    } else if (langCode == "en") {
      title = product.name_en.trim();
      description = product.maininfo_en.trim();
    } else if (langCode == "ru") {
      title = product.name_ru.trim();
      description = product.maininfo_ru.trim();
    }
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
            title: new Text(title),
            backgroundColor: Colors.lightGreen,
            actions: <Widget>[
              GestureDetector(
                child: new Container(
                  child: new Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(right: 16),
                ),
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(img,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              )
            ]),
        body: _buildPageContent(context));
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
    img = product.hasphoto;
    if (img == "1") {
      img = "https://kenddenshehere.az/images/pr/" + product.code + ".jpg";
    } else {
      img = null;
    }
  }

  Widget _buildPageContent(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              //_buildItemCard(context),
              GestureDetector(
                child: _buildItemImage(),
                onTap: () {
                  Route route = MaterialPageRoute(
                      builder: (BuildContext context) => GroceryBigImage(
                            code: product.code,
                          ));
                  Navigator.push(context, route);
                },
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            GroceryTitle(text: title),
                            SizedBox(
                              height: 5.0,
                            ),
                            GrocerySubtitle(
                                text: product.counttype + " " + product.price),
                            new Container(
                              margin: EdgeInsets.all(6),
                              child: RatingStarWidget(5, 4, 22),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20, top: 8),
                      )),
                  Expanded(
                    child: new Container(
                      child: addedWidget(),
                      margin: EdgeInsets.only(right: 20, top: 30, left: 20),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: GrocerySubtitle(text: description)),
//              new Container(
//                decoration: BoxDecoration(
//                    border: new Border.all(
//                      color: Colors.grey,
//                    ),
//                    borderRadius: BorderRadius.circular(4)),
//                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
//                padding: EdgeInsets.all(10),
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    new Container(
//                      margin: EdgeInsets.only(top: 8),
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          new CircleAvatar(
//                            child: Icon(
//                              Icons.chat,
//                              size: 15,
//                            ),
//                            maxRadius: 16,
//                            backgroundColor: Colors.green,
//                          ),
//                          new Container(
//                            margin: EdgeInsets.only(left: 10),
//                            child: new Text("Read Reviews (1)"),
//                          )
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              ),
            ],
          ),
        ),
      ],
    );
  }

  addedWidget() {
    if (!isAdded) {
      return new GestureDetector(
        child: new Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: new Container(
            padding: EdgeInsets.all(8),
            color: Colors.lightGreen,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new SizedBox(
                  child: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  height: 20,
                  width: 20,
                ),
                new Container(
                  child: new Text(
                    "Sebete elave et",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        onTap: () {
          setState(() {
            isAdded = true;
            Networks.addToBasket(product.id, amount.toString()).then((onvalue) {
              print(onvalue);
            });
            // widget.viewModel.onAddedProduct(product);
          });
        },
      );
    } else {
      return new Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(top: 8, bottom: 8),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        alignment: Alignment.topRight,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new GestureDetector(
              child: new Icon(Icons.remove),
              onTap: () {
                setState(() {
                  amount--;
                  if (amount < 1) {
                    isAdded = false;
                    amount = 1;
                    Networks.removeFromBasket(product.id).then((onvalue) {
                      print(onvalue);
                    });
                  }
                });
              },
            ),
            new Text(
              amount.toString(),
              style: new TextStyle(fontSize: 18),
            ),
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                setState(() {
                  amount++;
                });
                Networks.addToBasket(product.id, amount.toString())
                    .then((onvalue) {
                  print(onvalue);
                });
              },
            ),
          ],
        ),
      );
    }
  }

  Container _buildItemImage() {
    return Container(
      padding:
          EdgeInsets.only(left: 20.0, top: 16.0, right: 20.0, bottom: 16.0),
      child: Material(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: new Center(
                      child: FadeInImage.assetNetwork(
                    placeholder: "images/noimage.png",
                    image: img,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                        fadeInCurve: Curves.bounceOut,
                        fit: BoxFit.cover,
                  ))),
              Positioned(
                  bottom: 8.0,
                  right: 8.0,
                  child: Container(
                    child: IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.pink[400],
                        size: 36,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        Networks.add_Remove_WishList(product.id)
                            .then((onvalue) {
                          print(onvalue);
                        });
                      },
                    ),
                  )),
            ],
          )),
    );
  }

  getImage() async {
    var image = await Image.network(
      img,
      fit: BoxFit.cover,
    );
    return image;
  }
}
