import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/manager/controller.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<ManagerController>(
      init: ManagerController(),
      (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RoundedButton.text(
                    'Quản lý doanh thu',
                    () {},
                  ),
                  AppSize.h8,
                  RoundedButton.text(
                    'Quản lý tài khoản nhân viên',
                    () {},
                  ),
                  AppSize.h8,
                  // RoundedButton.text(
                  //   'Quản lý menu',
                  //   () {},
                  // ),
                  // AppSize.h8,
                ],
              ).safePad(),
            ),
          ),
        );
      },
    );
  }
}
