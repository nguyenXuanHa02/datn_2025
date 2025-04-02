import 'package:flutter/material.dart';
import 'package:kichikichi/core/base_widget/bottom_nav_item.dart';

Widget customerBottomNav(int selectedIndex, Function(int) onTap) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: selectedIndex,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    elevation: 0,
    items: [
      bottomNavigationBarItem(
        0,
        'Home',
        isSelected: selectedIndex == 0,
      ),
      bottomNavigationBarItem(
        1,
        'Home',
        isSelected: selectedIndex == 1,
      ),
      bottomNavigationBarItem(
        2,
        'Home',
        isSelected: selectedIndex == 2,
      ),
      bottomNavigationBarItem(
        3,
        'Home',
        isSelected: selectedIndex == 3,
      ),
    ],
    onTap: onTap,
  );
}
