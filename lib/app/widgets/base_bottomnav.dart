import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BaseBottomNav extends StatelessWidget {
  const BaseBottomNav({
    required this.items,
    required this.currentPage,
    required this.onTap,
    super.key,
  });

  final List<SalomonBottomBarItem> items;
  final int currentPage;
  final dynamic Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: const StadiumBorder(),
        child: SalomonBottomBar(
          backgroundColor: Colors.white,
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 300),
          selectedItemColor: AppColors.orangeColor,
          selectedColorOpacity: 0.1,
          unselectedItemColor: Colors.grey.shade600,
          currentIndex: currentPage,
          margin: EdgeInsets.all(6.r),
          onTap: onTap,
          items: items,
        ),
      ),
    );
  }
}
