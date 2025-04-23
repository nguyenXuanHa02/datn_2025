import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugButton extends StatelessWidget {
  const DebugButton(this.invoke, {super.key, this.tag});
  final Function() invoke;
  final String? tag;
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return TextButton(onPressed: invoke, child: Text(tag ?? 'DebugWidget'));
    }
    return const SizedBox.shrink();
  }
}
