import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class BaseFormInfo extends StatelessWidget {
  const BaseFormInfo({
    required this.message,
    this.bgColor,
    this.fgColor,
    super.key,
  });

  final String message;
  final Color? bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Icon(MingCute.information_line, size: 16.sp, color: fgColor),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: fgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
