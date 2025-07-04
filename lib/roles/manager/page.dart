import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/manager/controller.dart';
import 'package:kichikichi/roles/manager/menu/page.dart';
import 'package:kichikichi/roles/manager/revenue/page.dart';
import 'package:kichikichi/roles/manager/staffmanage/page.dart';

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
                    'Thống kê doanh thu',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RevenuePage(),
                      ));
                    },
                  ),
                  AppSize.h8,
                  RoundedButton.text(
                    'Quản lý tài khoản nhân viên',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManagerCreateStaffPage(),
                      ));
                    },
                  ),
                  AppSize.h8,
                  RoundedButton.text(
                    'Quản lý menu',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ManagerMenuManage(),
                      ));
                    },
                  ),
                  AppSize.h8,
                ],
              ).safePad(),
            ),
          ),
        );
      },
    );
  }
}
