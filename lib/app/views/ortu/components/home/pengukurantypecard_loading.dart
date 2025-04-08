import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget pengukuranTypeCardLoading() {
  return Skeletonizer(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF85DFC9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Skeleton.keep(
                      child: Icon(
                        MingCute.dashboard_3_line,
                        size: 32.sp,
                        color: const Color(0xFF00A77C),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Skeleton.keep(
                      child: Text(
                        'Berat\nBadan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'xxxxxxxx',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF81B5FE),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Skeleton.keep(
                      child: Icon(
                        MingCute.fullscreen_2_line,
                        size: 32.sp,
                        color: const Color(0xFF126DFF),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Skeleton.keep(
                      child: Text(
                        'Tinggi\nBadan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'xxxxxxxx',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB894),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Skeleton.keep(
                      child: Icon(
                        MingCute.head_line,
                        size: 32.sp,
                        color: const Color(0xFFEB6E2B),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Skeleton.keep(
                      child: Text(
                        'Lingkar\nKepala',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'xxxxxxxx',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Skeleton.keep(
              child: Text(
                'Pengukuran Terakhir :',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '01 Desember 0000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
