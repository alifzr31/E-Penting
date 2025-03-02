import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget headerProfileLoading() {
  return Skeletonizer(
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          foregroundDecoration: BoxDecoration(
            color: AppColors.greyFormField,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(radius: 24.r),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posyandu',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                'xxxxxxxxxxxxxxxxx',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
