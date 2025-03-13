import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

class BaseEmptyState extends StatelessWidget {
  const BaseEmptyState({
    required this.message,
    this.showButton = true,
    this.iconButton = MingCute.add_line,
    this.labelButton = 'Tambah Pengukuran Baru',
    this.onPressedButton,
    required this.totalData,
    super.key,
  });

  final String message;
  final bool showButton;
  final IconData iconButton;
  final String labelButton;
  final void Function()? onPressedButton;
  final String totalData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              '${AppStrings.assetsLotties}/empty.json',
              width: 180.w,
              frameRate: const FrameRate(144),
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: showButton ? 6.h : 4.h),
            if (showButton)
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: BaseOutlineButtonIcon(
                  borderColor: AppColors.orangeColor,
                  fgColor: AppColors.orangeColor,
                  icon: iconButton,
                  label: labelButton,
                  onPressed: onPressedButton,
                ),
              ),
            if (showButton) SizedBox(height: 8.h),
            Text(
              'Seluruh data telah ditampilkan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
            Text(
              '(Total: $totalData)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
