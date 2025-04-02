import 'package:flutter/material.dart';
import 'package:kichikichi/commons/default/error.dart';
import 'package:kichikichi/core/routers/route_cons.dart';
import 'package:kichikichi/roles/customer/home/preorder/page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteCons.start:
        return MaterialPageRoute(builder: (_) => Container());
      case RouteCons.customerHomePreorder:
        return MaterialPageRoute(builder: (_) => const CustomerHomePreorder());

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
