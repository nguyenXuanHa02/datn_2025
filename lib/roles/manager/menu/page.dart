import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/manager/menu/view.dart';

class ManagerMenuManage extends StatefulWidget {
  const ManagerMenuManage({super.key});

  @override
  State<ManagerMenuManage> createState() => _ManagerMenuManageState();
}

class _ManagerMenuManageState extends State<ManagerMenuManage> {
  @override
  Widget build(BuildContext context) {
    return MenuListPage();
  }
}
