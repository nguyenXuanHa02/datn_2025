import 'package:flutter/material.dart';

const String emptyText = '--';

extension TextStyleExtension on TextStyle {
  Widget text(
    String? content, {
    TextAlign? align,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Text(
      content ?? emptyText,
      style: this,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
