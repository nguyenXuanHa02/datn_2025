import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension PaddingExtensions on Widget {
  /// Adds padding on all sides
  Widget padAll(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// Adds symmetric padding (horizontal & vertical)
  Widget padSymmetric({double h = 0, double v = 0}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
        child: this,
      );

  /// Adds only top padding
  Widget padTop(double value) => Padding(
        padding: EdgeInsets.only(top: value),
        child: this,
      );

  /// Adds only bottom padding
  Widget padBottom(double value) => Padding(
        padding: EdgeInsets.only(bottom: value),
        child: this,
      );

  /// Adds only left padding
  Widget padLeft(double value) => Padding(
        padding: EdgeInsets.only(left: value),
        child: this,
      );

  /// Adds only right padding
  Widget padRight(double value) => Padding(
        padding: EdgeInsets.only(right: value),
        child: this,
      );

  /// Adds custom padding with EdgeInsets
  Widget pad(EdgeInsetsGeometry padding) => Padding(
        padding: padding,
        child: this,
      );

  Widget safePad() => Padding(
        padding: const EdgeInsets.all(16),
        child: this,
      );
  Widget cardPad() => Padding(
        padding: const EdgeInsets.all(8),
        child: this,
      );
  Widget fadeIn({int? fade}) => animate().fadeIn(duration: fade?.ms ?? 350.ms);

  Widget fadeInSlideUp({
    int? fade,
    double? y,
  }) =>
      animate()
          .fadeIn(duration: fade?.ms ?? 350.ms)
          .slide(begin: Offset(0, y ?? 2));
}
