import 'package:flutter/material.dart';
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/main.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/ui/page/map/map_view.dart';

class CheckoutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CheckoutsPageState();
  }
}

class CheckoutsPageState extends State<CheckoutsPage> {
  var selectedIndex = 0;
  String choice = "11:30-13:00";
  ScrollController _scrollController;
  bool _isOnTop = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Checkout"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      body: new ListView(
        controller: _scrollController,
        children: <Widget>[
          _getAccountTypeSection(),
          _getDropDown(),
          new Container(
            margin: EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Unvani daxil edin',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            ),
          ),
          GestureDetector(
            child: _getGoogleMap(),
            onTap: _isOnTop ? _scrollToBottom : _scrollToTop,
          ),
          new Container(
            child: RaisedButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, "/confirm_order");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("NEXT", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    setState(() => _isOnTop = true);
  }

  _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
    setState(() => _isOnTop = false);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  Widget _getAccountTypeSection() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Card(
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTapUp: (tapDetail) {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
                        stops: [0.0, 0.5],
                        colors: selectedIndex == 0
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
                                Color(0xFF47E497),
                                Color(0xFF47E0D6)
                              ]
                            : [Colors.white, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.credit_card,
                            color: selectedIndex == 0
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Online\nOdenish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTapUp: (tapDetail) {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // new
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight, // new
                        end: Alignment.bottomLeft, // new
                        // Add one stop for each color.
                        // Stops should increase
                        // from 0 to 1
                        stops: [0.0, 0.5],
                        colors: selectedIndex == 1
                            ? [
                                // Colors are easy thanks to Flutter's
                                // Colors class.
                                Color(0xFF47E497),
                                Color(0xFF47E0D6)
                              ]
                            : [Colors.white, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance,
                            color: selectedIndex == 1
                                ? Colors.white
                                : Color(0xFF939192),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Yerinde\nOdenish',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xFF939192)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getDropDown() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Text(
                'Catdirilma vaxti',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: Container(
//              height: 42.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Card(
                      margin: EdgeInsets.only(left: 8),
                      child: PopupMenuButton<String>(
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return Constants.deliveryTimes.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                          child: new Container(
                              height: 50,
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ListTile(
                                title: Text(
                                  choice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0),
                                ),
                                trailing: new Icon(
                                  Icons.arrow_drop_down,
                                  size: 20,
                                ),
                              ))),
                    ),
                    new Container(
                      padding: EdgeInsets.all(12),
                      child: (choice == "Tecili catdirilma")
                          ? Text('Təcili sifarişlərə 2 AZN əlavə tətbiq olunur',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.0,
                                  color: Colors.redAccent))
                          : new SizedBox(
                              height: 0,
                              width: 0,
                            ),
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  void choiceAction(String choice) {
    setState(() {
      this.choice = choice;
    });
    if (choice == Constants.FirstItem) {
      print('I First Item');
    } else if (choice == Constants.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants.ThirdItem) {
      print('I Thired Item');
    }
  }

  _getGoogleMap() => MapPage1();
}
