import 'package:flutter/material.dart';
import 'package:punchme/res/app_colors.dart';
import 'package:punchme/res/app_styles.dart';

import 'package:punchme/utils/size_config.dart';

class JxText extends StatelessWidget {
  JxText(this.text,
      {this.color = AppColors.white,
      this.size = 6,
      this.isBold = false,
      this.isCenter = false,
      this.maxLines = 1});
  final String text;
  final bool isBold;
  final Color color;
  final double size;
  final int maxLines;
  final isCenter;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        textAlign: isCenter ? TextAlign.center : TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.idleTxt.copyWith(
            color: color,
            fontSize: SizeConfig.width * size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal));
  }
}
