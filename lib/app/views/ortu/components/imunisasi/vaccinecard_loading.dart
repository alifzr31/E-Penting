import 'package:epenting/app/models/vaccine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget vaccineCardLoading(List<Vaccine> vaccines) {
  return Skeletonizer(
    child: Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 6.h,
            childAspectRatio: 5.6,
          ),
          itemCount: vaccines.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.red,
              ),
            );
          },
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Skeleton.keep(
              child: Text(
                'Terakhir Diperbarui :',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'xxxxxxxxxxxxxxxx',
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
