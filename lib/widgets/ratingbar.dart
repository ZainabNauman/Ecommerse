import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingBarWidget extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;

  RatingBarWidget({super.key, this.starCount = 5, this.rating = 0, this.onRatingChanged});

  Widget buildStar(BuildContext context, int index) {
    Size size=responseMediaQuery(context);
    Icon icon;
    if (index >= rating) {
      icon =  Icon(
        Icons.star_border,
        color: Colors.black,
        size: size.width*0.03,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon =  Icon(
        Icons.star_half,
        color: ColorConstant.primaryColor,
        size: size.width*0.03,
      );
    } else {
      icon =  Icon(
        Icons.star,
        color: ColorConstant.primaryColor,
        size: size.width*0.03,
      );
    }
    return  InkResponse(
      // ignore: unnecessary_null_comparison
      //onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Row(children:  List.generate(starCount, (index) => buildStar(context, index)));
  }
}