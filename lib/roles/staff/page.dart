import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/roles/staff/pay/controller.dart';

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
            child: RefreshIndicator(
              onRefresh: controller.getAllOrder,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: List.generate(
                  controller.changeList.length,
                  (index) => Text(controller.changeList[index]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
