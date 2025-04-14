import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class PemberianAsiItem extends StatelessWidget {
  const PemberianAsiItem({
    required this.label,
    required this.color,
    this.onSelectedPemberianAsi,
    super.key,
  });

  final String label;
  final Color color;
  final void Function()? onSelectedPemberianAsi;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.blueColor),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: InkWell(
            onTap: onSelectedPemberianAsi,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  MingCute.check_fill,
                  size: 11.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
