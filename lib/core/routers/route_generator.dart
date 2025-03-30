import 'package:flutter/material.dart';
import 'package:kichikichi/core/routers/route_cons.dart';
import 'package:kichikichi/pages/default/error.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteCons.start:
        return MaterialPageRoute(builder: (_) => Container());

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
