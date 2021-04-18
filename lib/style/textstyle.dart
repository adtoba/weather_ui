import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_ui/style/colors.dart';

class WStyles {
  static TextStyle locationStyle = TextStyle(
    color: WColors.white,
    fontWeight: FontWeight.w400,
    fontSize: 25,
  );

  static TextStyle dayStyle = TextStyle(color: Colors.grey, fontSize: 16);

  static TextStyle tempStyle = TextStyle(color: Colors.black, fontSize: 16);

  static TextStyle dateStyle = TextStyle(
      color: WColors.white, fontSize: 12, fontWeight: FontWeight.w600);

  static TextStyle conditionStyle = TextStyle(
      color: WColors.white, fontWeight: FontWeight.w600, fontSize: 15);

  static TextStyle temperatureStyle =
      TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600);

  static TextStyle titleStyle = TextStyle(fontSize: 18, color: Colors.grey);

  static TextStyle subtitleStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: WColors.black);
}
