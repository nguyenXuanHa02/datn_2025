import 'package:flutter/widgets.dart';

abstract class AppSize {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  // Fixed sizes
  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;

  static const double radiusSmall = 8;
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;

  static const double iconSizeSmall = 20;
  static const double iconSizeMedium = 30;
  static const double iconSizeLarge = 40;

  // Dynamic sizes (relative to screen width)
  // static double w(double value) => screenWidth * (value / 100);
  // static double h(double value) => screenHeight * (value / 100);
  static Widget w(double value) => SizedBox(
        width: value,
      );
  static Widget h(double value) => SizedBox(
        height: value,
      );
  static Widget get h16 => h(16);
  static Widget get h32 => h(32);
  static Widget get h64 => h(64);
  static Widget get h8 => h(8);
  static Widget get w8 => w(8);
  static Widget get w16 => w(16);
}
