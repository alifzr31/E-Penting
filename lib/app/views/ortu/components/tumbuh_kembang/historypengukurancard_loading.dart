import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget historyPengukuranCardLoading() {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    itemCount: 2,
    itemBuilder: (context, index) {
      return Skeletonizer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 8.r,
                  backgroundColor: const Color(0xFF80B4FF),
                ),
                if (index != 1) SizedBox(height: 4.h),
                if (index != 1)
                  Skeleton.keep(
                    child: Container(
                      height: 36.r,
                      width: 1,
                      color: const Color(0xFF96C7FF),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Card(
                color: const Color(0xFF96C7FF),
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.r),
                    bottomRight: Radius.circular(2.r),
                    topRight: Radius.circular(6.r),
                    topLeft: Radius.circular(2.r),
                  ),
                ),
                margin: EdgeInsets.only(bottom: index == 3 ? 4 : 8),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'xxxxxxxxxxxxxxxx',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Skeleton.keep(
                                  child: Icon(
                                    MingCute.dashboard_3_line,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: Text(
                                    'xxxxx kg',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Skeleton.keep(
                                  child: Icon(
                                    MingCute.fullscreen_2_line,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: Text(
                                    'xxxxx cm',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
