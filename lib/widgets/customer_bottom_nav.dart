import 'package:kichikichi/core/base_widget/bottom_nav_item.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

Widget customerBottomNav(int selectedIndex, Function(int) onTap) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: selectedIndex,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 0,
    selectedFontSize: 12,
    unselectedFontSize: 1,
    selectedItemColor: AppColors.primary,
    items: [
      bottomNavigationBarItem(0, 'Trang chủ',
          isSelected: selectedIndex == 0, svg: 'assets/svg/home.svg'),
      bottomNavigationBarItem(1, 'Tài khoản',
          isSelected: selectedIndex == 1, svg: 'assets/svg/account.svg'),
      // bottomNavigationBarItem(
      //   2,
      //   'Home',
      //   isSelected: selectedIndex == 2,
      // ),
      // bottomNavigationBarItem(
      //   3,
      //   'Home',
      //   isSelected: selectedIndex == 3,
      // ),
    ],
    onTap: onTap,
  ).fadeInSlideUp();
}
