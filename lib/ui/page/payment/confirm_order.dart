import 'package:flutter/material.dart';

class ConfirmOrderPage extends StatelessWidget{
  final String address = "Hesen bey zerdabi, Baki";
  final String phone="9818522122";
  final double total = 50;
  final double delivery = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Confirm Order"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal"),
              Text("AZN: $total"),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Delivery fee"),
              Text("AZN: $delivery"),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total", style: Theme.of(context).textTheme.title,),
              Text("AZN: ${total+delivery}", style: Theme.of(context).textTheme.title),
            ],
          ),
          SizedBox(height: 20.0,),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Delivery Address".toUpperCase())
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                activeColor: Colors.green[700],
                selected: true,
                value: address,
                groupValue: address,
                title: Text(address),
                onChanged: (value){},
              ),
              RadioListTile(
                selected: false,
                value: "New Address",
                groupValue: address,
                title: Text("Choose another delivery address"),
                onChanged: (value){},
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text("Contact".toUpperCase())
              ),
              RadioListTile(
                activeColor: Colors.green[700],
                selected: true,
                value: phone,
                groupValue: phone,
                title: Text("Konul Eminova"),
                onChanged: (value){},
              ),
              RadioListTile(
                activeColor: Colors.green[700],
                selected: true,
                value: phone,
                groupValue: phone,
                title: Text("+"+phone),
                onChanged: (value){},
              ),
            ],
          ),
          SizedBox(height: 20.0,),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text("Payment Option".toUpperCase())
          ),
          RadioListTile(
            activeColor: Colors.green[700],
            groupValue: true,
            value: true,
            title: Text("Cash on Delivery"),
            onChanged: (value){},
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color:  Colors.green,
              onPressed: ()=> {
                Navigator.pushNamed(context, "/card_storage")
              },
              child: Text("Confirm Order", style: TextStyle(
                  color: Colors.white
              ),),
            ),
          )
        ],
      ),
    );
  }


}