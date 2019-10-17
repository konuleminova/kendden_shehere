import 'package:flutter/material.dart';

class PaymentErrorDialog extends StatelessWidget {
  BuildContext context;
  String title;
  String subtitle;

  PaymentErrorDialog(this.context,this.title,this.subtitle);

  final image = 'assets/img/3.jpg';
  final TextStyle subtitles = TextStyle(fontSize: 12.0, color: Colors.grey);
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
                  title,
                  style: TextStyle(color: Colors.red,fontSize: 20),
                ),
                Text(
                 subtitle,
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
                   Navigator.pop(this.context,true);
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
