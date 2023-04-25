import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final double size;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating({this.starCount = 5, this.rating = .0,this.size = .0, required this.onRatingChanged, required this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border_rounded,
        color: Theme.of(context).buttonColor,
        size: size,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    } else {
      icon = new Icon(
        Icons.star_rounded,
        color: color ?? Theme.of(context).primaryColor,
        size: size,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
  }
}