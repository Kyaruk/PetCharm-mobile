import 'package:flutter/material.dart';
import 'package:ff_stars/ff_stars.dart';

Widget returnStars(num userScore, double width) {
  return FFStars(
    normalStar: Image.asset("assets/images/christmasNormal.png"),
    selectedStar: Image.asset("assets/images/christmasSelected.png"),
    starWidth: width,
    defaultStars: userScore.toDouble(),
    justShow: true,
  );
}
