import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingStarWidget extends StatefulWidget {
  double rating, size;
  int starCount;

  RatingStarWidget(this.starCount, this.rating, this.size);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RatingStarState();
  }
}

class RatingStarState extends State<RatingStarWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmoothStarRating(
      allowHalfRating: true,
      onRatingChanged: (v) {
        // rating = v;
        widget.rating = v;
        setState(() {
          print("rate chage");
        });
      },
      starCount: widget.starCount,
      rating: widget.rating,
      size: widget.size,
      color: Colors.green,
      borderColor: Colors.green,
    );
  }
}
