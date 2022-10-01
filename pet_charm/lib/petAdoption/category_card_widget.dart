import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';
import 'category.dart';

class CategoryCardWidget extends StatelessWidget {
  final Category category;

  CategoryCardWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.0,
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 12.0),
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: Center(
                      child: SvgPicture.asset(
                    this.category.icon,
                    width: 45.0,
                    height: 45.0,
                  ))),
            ),
            Spacer(),
            Text(
              category.name,
              style: kSubtitleStyle,
            )
          ],
        ));
  }
}
