import 'package:flutter/material.dart';

extension PaddingExtensions on Widget {
  /// Adds padding on all sides
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Adds symmetric padding (horizontal & vertical)
  Widget paddingSymmetric({double h = 0, double v = 0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
        child: this,
      );

  /// Adds only top padding
  Widget paddingTop(double value) => Padding(
        padding: EdgeInsets.only(top: value),
        child: this,
      );

  /// Adds only bottom padding
  Widget paddingBottom(double value) => Padding(
        padding: EdgeInsets.only(bottom: value),
        child: this,
      );

  /// Adds only left padding
  Widget paddingLeft(double value) => Padding(
        padding: EdgeInsets.only(left: value),
        child: this,
      );

  /// Adds only right padding
  Widget paddingRight(double value) => Padding(
        padding: EdgeInsets.only(right: value),
        child: this,
      );

  /// Adds custom padding with EdgeInsets
  Widget padding(EdgeInsetsGeometry padding) => Padding(
        padding: padding,
        child: this,
      );
}
