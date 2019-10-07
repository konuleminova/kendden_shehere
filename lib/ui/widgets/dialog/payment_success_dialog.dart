import 'package:flutter/material.dart';

class PaymentSuccessDialog extends StatelessWidget {
  BuildContext context;

  PaymentSuccessDialog(this.context);

  final image = 'assets/img/3.jpg';
  final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Thank You!",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  "Your transaction was successful",
                  style: label,
                ),
                Divider(),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.done_outline,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                   Navigator.pop(this.context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("OK", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
