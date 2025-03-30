import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  Widget text(
    String content, {
    TextAlign? align,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      content,
      style: this,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
