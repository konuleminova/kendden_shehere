import 'package:flutter/material.dart';
import 'package:kendden_shehere/localization/app_translations.dart';
import 'package:kendden_shehere/ui/widgets/rating_star.dart';

class RatingStarDialog extends StatelessWidget {
  final image = 'assets/img/3.jpg';
  final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Dialog(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: new Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          AppTranslations.of(context).text('thank_you'),
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          AppTranslations.of(context).text('rate_app'),
                          style: label,
                        ),
                        Divider(),
                        SizedBox(
                          child: new Container(
                            child: new TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              decoration: InputDecoration(
                                  hintText: AppTranslations.of(context)
                                      .text('review'),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[RatingStarWidget(5, 0, 30)],
                              ),
                              SizedBox(width: 10.0),
                              CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: new IconButton(
                                    icon: new Icon(Icons.send),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )),
                            ],
                          ),
                          alignment: Alignment.centerRight,
                        )
                      ],
                    ),
                    new Container(
                      alignment: Alignment.topRight,
                      child: new IconButton(
                        icon: new Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        alignment: Alignment.topRight,
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
