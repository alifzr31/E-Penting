import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({
    required this.currentPage,
    required this.onTap,
    super.key,
  });

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
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                currentPage == 0 ? MingCute.home_3_fill : MingCute.home_3_line,
                size: 21.sp,
              ),
              title: Text(
                'Beranda',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                currentPage == 1
                    ? MingCute.dashboard_4_fill
                    : MingCute.dashboard_4_line,
                size: 21.sp,
              ),
              title: Text(
                'Pengukuran',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                currentPage == 2
                    ? BoxIcons.bxs_first_aid
                    : BoxIcons.bx_first_aid,
                size: 21.sp,
              ),
              title: Text(
                'Imunisasi',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                currentPage == 3 ? MingCute.emoji_fill : MingCute.emoji_line,
                size: 21.sp,
              ),
              title: Text(
                'Balita',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
