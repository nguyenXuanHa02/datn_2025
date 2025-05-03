import 'package:flutter/material.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/roles/account/controller.dart';
import 'package:kichikichi/roles/account/page.dart';
import 'package:kichikichi/roles/customer/home/page.dart';
import 'package:kichikichi/roles/manager/page.dart';
import 'package:kichikichi/roles/staff/pay/page.dart';
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
    return BaseScaffold<AccountController>(
      init: AccountController(),
      showLoading: false,
      (p0) {
        return Scaffold(
          body: IndexedStack(
            index: bottomBarIndex,
            children: [
              (p0.currentRole == AccountRole.manager)
                  ? const ManagerPage()
                  : (p0.currentRole == AccountRole.staff)
                      ? UserInformation()
                      : const CustomerHomePage(),
              const AccountPage()
            ],
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
      },
    );
  }
}
