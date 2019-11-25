import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/util/helper_class.dart';

class PaymentSuccessDialog extends StatelessWidget {
  BuildContext context;

  PaymentSuccessDialog(this.context);

  final image = 'assets/img/3.jpg';
  final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 300,
      color: Colors.transparent,
      child: Dialog(
        backgroundColor: Colors.transparent,
        child:
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset('images/ks/happy.png'),
//            Align(
//                alignment: Alignment.bottomCenter,
//                child: Container(
//                  width: 150,
//                  height: 50,
//                  child: Text(
//                    AppTranslations.of(context).text('your_transaction'),
//                    style: TextStyle(color: Colors.white,),
//                    textAlign: TextAlign.center,
//                  ),
//                  alignment: Alignment.bottomCenter,
//                ))
          ],
        )
      ),
    ));
  }
}
