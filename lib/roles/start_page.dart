import 'package:flutter/material.dart';
import 'package:kichikichi/roles/account/page.dart';
import 'package:kichikichi/roles/customer/home/page.dart';
import 'package:kichikichi/widgets/customer_bottom_nav.dart';

class CustomerStartPage extends StatefulWidget {
  const CustomerStartPage({super.key});

  @override
  _CustomerStartPageState createState() => _CustomerStartPageState();
}

class _CustomerStartPageState extends State<CustomerStartPage> {
  _CustomerStartPageState();

  int bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomBarIndex,
        children: const [CustomerHomePage(), AccountPage()],
      ),
      bottomNavigationBar: customerBottomNav(
        bottomBarIndex,
        (p0) {
          setState(() {
            bottomBarIndex = p0;
          });
        },
      ),
    );
  }
}
