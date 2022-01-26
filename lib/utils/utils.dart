import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = const Color(0xFF1E1E1E);
  static Color appBarColor = const Color(0xff172E3E);
  static Color clickableFontColor = const Color(0xFF2E84BF);
  static Color brightFontColor = const Color(0xFFFFFFFF);
}

class AppFonts {
  static double submitButtonsFontSize = 24;
  static double cashFontSize = 18;
  static TextStyle appBarFont = TextStyle(
      fontSize: 17, color: AppColors.brightFontColor, fontFamily: "Prototype");
  static TextStyle titleFont = TextStyle(
      fontSize: 26, color: AppColors.brightFontColor, fontFamily: "Prototype");
  static TextStyle infoCardFont = TextStyle(
      fontSize: 14, color: AppColors.backgroundColor, fontFamily: "Prototype");
}
