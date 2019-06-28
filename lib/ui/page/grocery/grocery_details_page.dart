import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/data/model/product_model.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';
import 'package:kendden_shehere/ui/widgets/list_item/glistitem2.dart';
import 'package:kendden_shehere/ui/widgets/gtile_title.dart';
import 'package:share/share.dart';

class GroceryDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GroceryDetailsState();
  }
}

class GroceryDetailsState extends State<GroceryDetailsPage> {
  bool isAdded = false, isLiked = false;

  var amount = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
            title: new Text("Product List"),
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
                  Share.share("https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190503",
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              )
            ]),
        body: _buildPageContent(context));
  }

  Widget _buildPageContent(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              //_buildItemCard(context),
              _buildItemImage(
                  image:
                      'https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190501'),
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
                            GroceryTitle(text: "Local Cabbage"),
                            SizedBox(
                              height: 5.0,
                            ),
                            GrocerySubtitle(text: "1 kg" + "/ 1 azn"),
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
                  child: GrocerySubtitle(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras scelerisque nibh ut eros suscipit, vel cursus dolor imperdiet. Proin volutpat ligula eget purus maximus tristique. Pellentesque ullamcorper libero vitae metus feugiat fringilla. Ut luctus neque sed tortor placerat, faucibus mollis risus ullamcorper. Cras at nunc et odio ultrices tempor et.")),
              new Container(
                decoration: BoxDecoration(
                    border: new Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                padding: EdgeInsets.all(10),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 8),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new CircleAvatar(
                            child: Icon(
                              Icons.chat,
                              size: 15,
                            ),
                            maxRadius: 16,
                            backgroundColor: Colors.green,
                          ),
                          new Container(
                            margin: EdgeInsets.only(left: 10),
                            child: new Text("Read Reviews (1)"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: GroceryTitle(text: "Related Items")),
              GroceryListItemTwo(new Product(
                  image:
                      "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=5&d=20190429",
                  title: "Sample",
                  subtitle: "Subtitle",
                  price: "1 AZN",
                  isLiked: false,
                  isAdded: false,
                  amount: 1)),
              GroceryListItemTwo(new Product(
                  image:
                      "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=2&d=20190501",
                  title: "Sample",
                  subtitle: "Subtitle",
                  price: "2 AZN",
                  isLiked: false,
                  isAdded: false,
                  amount: 1)),
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
              },
            ),
          ],
        ),
      );
    }
  }

  Container _buildItemImage({String image}) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 16.0),
      child: Material(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: new Center(
                  child: Image.network(
                    "https://pulapul.com/PulaPul/?action=GetImage&module=Campaigns&fileid=5&d=20190429",
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                color: Colors.black.withOpacity(0.6),
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink[400],
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (isLiked) {
                          isLiked = false;
                          // widget.viewModel.onAddedProduct(product);
                        } else {
                          isLiked = true;
                          //   widget.viewModel.onAddedProduct(product);
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
