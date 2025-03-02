import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget headerPercentageLoading() {
  return Skeletonizer(
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'xxxxxx',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Skeleton.keep(
                child: Text(
                  'Balita Terdata',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        CircleAvatar(radius: 30.r),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 8.r,
                    width: 8.r,
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '45% Perempuan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 8.r,
                    width: 8.r,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '55% Laki-laki',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
