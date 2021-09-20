import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fmm/constants/styles.dart';
import 'package:fmm/models/colors.dart';

class CustomStyles {
  static const boldText =
      TextStyle(color: CustomColors.textColor, fontWeight: FontWeight.bold);
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
