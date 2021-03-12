import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static final idleTxt = TextStyle(
      fontFamily: 'MavenPro',
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);

  static final btnTxt = TextStyle(
      fontFamily: 'MavenPro',
      fontWeight: FontWeight.bold,
      color: AppColors.black,
      fontSize: 20,
      decoration: TextDecoration.none);

  static final generalTxtField = InputDecoration(
    contentPadding: EdgeInsets.zero,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8))),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8))),
  );
  static final minimalBorderRadius = BorderRadius.all(Radius.circular(10));

  static final minimalBorder =
      RoundedRectangleBorder(borderRadius: minimalBorderRadius);
}
