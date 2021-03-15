import 'package:flutter/material.dart';
import 'package:punchme/common/text.dart';
import 'package:punchme/res/app_colors.dart';

class JxMarker extends StatelessWidget {
  JxMarker(this.isPunch);
  final bool isPunch;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
            color: AppColors.yellow,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
        child: JxText(
          isPunch ? 'Punch' : 'Points',
          size: 3,
          isBold: true,
          color: AppColors.black,
        ),
      ),
    );
  }
}
