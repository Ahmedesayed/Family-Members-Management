import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fmm/constants/styles.dart';
import 'package:fmm/models/colors.dart';

class CustomStyles {
  static const boldText =
      TextStyle(color: CustomColors.textColor, fontWeight: FontWeight.bold);
  static const ExtraBoldText =
      TextStyle(color: CustomColors.primaryColor, fontWeight: FontWeight.bold,fontSize: 20);
  static const lightText =
      TextStyle(color: CustomColors.lightTextColor);
  static const appBarBottomRadius = BorderRadius.only(
    topLeft: Radius.circular(APP_BOTTOM_BAR_RADIUS),
    topRight: Radius.circular(APP_BOTTOM_BAR_RADIUS),
  );

  static const appBarBottomShadow = <BoxShadow>[
    BoxShadow(
      color: Colors.black26,
      blurRadius: 5,
    ),
  ];
}
