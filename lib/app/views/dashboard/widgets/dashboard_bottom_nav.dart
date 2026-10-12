import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardBottomNav extends StatelessWidget {
  const new({
    required this.currentTab,
    required this.onTabChange,
    required this.tabs,
    super.key,
  });

  final int currentTab;
  final Function(int index) onTabChange;
  final List<GButton> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .only(
        left: 16,
        right: 16,
        bottom: context.deviceViewPadding.bottom + 16,
      ),
      child: Material(
        elevation: 1,
        clipBehavior: .antiAlias,
        shape: const StadiumBorder(),
        child: GNav(
          selectedIndex: currentTab,
          onTabChange: onTabChange,
          backgroundColor: Colors.white,
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 300),
          gap: 4,
          color: Colors.grey.shade600,
          activeColor: AppColors.orangeColor,
          tabMargin: const .all(8),
          iconSize: 24,
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: .w600,
            color: AppColors.orangeColor,
          ),
          tabBackgroundColor: AppColors.orangeColor.withValues(alpha: 0.1),
          padding: const .symmetric(horizontal: 10, vertical: 6),
          tabs: tabs,
        ),
      ),
    );
  }
}
