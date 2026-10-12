import 'package:e_penting/app/views/dashboard/widgets/dashboard_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ParentBottomNav extends StatelessWidget {
  const new({required this.currentTab, required this.onTabChange, super.key});

  final int currentTab;
  final Function(int index) onTabChange;

  @override
  Widget build(BuildContext context) {
    return DashboardBottomNav(
      currentTab: currentTab,
      onTabChange: onTabChange,
      tabs: [
        GButton(
          icon: currentTab == 0 ? RemixIcon.home2Fill : RemixIcon.home2Line,
          text: 'Beranda',
        ),
        GButton(
          icon: currentTab == 1
              ? RemixIcon.medicineBottleFill
              : RemixIcon.medicineBottleLine,
          text: 'Imunisasi',
        ),
        GButton(
          icon: currentTab == 2
              ? RemixIcon.lineChartFill
              : RemixIcon.lineChartLine,
          text: 'Tumbuh Kembang',
        ),
      ],
    );
  }
}
