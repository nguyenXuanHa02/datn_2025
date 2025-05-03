import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/roles/staff/arive/page.dart';
import 'package:kichikichi/roles/staff/pay/controller.dart';
import 'package:kichikichi/roles/staff/pay/page.dart';

import '../../core/imports/imports.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<StaffPayController>(
      init: StaffPayController(),
      (controller) {
        return Scaffold(
          body: SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(tabs: [
                    Tab(
                      text: 'Thu tiền',
                    ),
                    Tab(
                      text: 'Giao món',
                    )
                  ]),
                  Expanded(
                      child: TabBarView(
                          children: [StaffPayPage(), StaffArivePage()])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
