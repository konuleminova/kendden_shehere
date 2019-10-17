import 'package:flutter/material.dart';

class PaymentErrorDialog extends StatelessWidget {
  BuildContext context;

  PaymentErrorDialog(this.context);

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
                  "Catdirilma yoxdur!",
                  style: TextStyle(color: Colors.red,fontSize: 20),
                ),
                Text(
                  "Seçdiyiniz əraziyə hal hazırda çatdırılma yoxdur.",
                  style: label,
                ),
                Divider(),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
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
