import 'package:flutter/material.dart';

extension SizeExtensions on num {
  /// Returns a SizedBox with height equal to this value
  SizedBox get h => SizedBox(height: toDouble());

  /// Returns a SizedBox with width equal to this value
  SizedBox get w => SizedBox(width: toDouble());

  /// Returns a SizedBox with both width and height equal to this value
  SizedBox get wh => SizedBox(width: toDouble(), height: toDouble());
}
