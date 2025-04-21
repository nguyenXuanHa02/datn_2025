import 'package:flutter/material.dart';
import 'package:kichikichi/commons/default/error.dart';
import 'package:kichikichi/core/routers/route_cons.dart';
import 'package:kichikichi/roles/customer/home/order/page.dart';
import 'package:kichikichi/roles/customer/home/preorder/page.dart';
import 'package:kichikichi/roles/customer/home/scan/page.dart';
import 'package:kichikichi/roles/start_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteCons.start:
        return MaterialPageRoute(builder: (_) => const CustomerStartPage());
      case RouteCons.customerHomePreorder:
        return MaterialPageRoute(builder: (_) => const CustomerHomePreorder());

      case RouteCons.customerHomeChangePreorder:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      case RouteCons.customerHomeOrder:
        return MaterialPageRoute(
          builder: (context) => CustomerHomeOrder(settings.arguments as Map?),
        );
      case RouteCons.customerHomeOrderMore:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      case RouteCons.customerHomeScan:
        return MaterialPageRoute(
          builder: (context) => const CustomerHomeScan(),
        );
      case RouteCons.customerHomePayment:
        return MaterialPageRoute(
          builder: (context) => Container(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
