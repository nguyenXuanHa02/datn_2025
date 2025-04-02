import 'package:flutter/material.dart';

extension RoundShape on num {
  Widget roundedAll(Widget child) => ClipRRect(
        borderRadius: BorderRadius.circular(toDouble()),
        child: child,
      );
}
