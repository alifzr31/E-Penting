import 'package:epenting/app/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget pengukuranCardLoading(
  int dataLength, {
  bool shrinkWrap = false,
  bool withPadding = true,
  Color shimmerColor = const Color(0xFFEBEBF4),
  Color cardColor = Colors.white,
  double elevation = 1,
  double marginBottom = 10,
}) {
  return ListView.builder(
    shrinkWrap: shrinkWrap,
    physics: const NeverScrollableScrollPhysics(),
    padding: withPadding ? const EdgeInsets.all(16) : EdgeInsets.zero,
    itemCount: dataLength,
    itemBuilder: (context, index) {
      return Skeletonizer(
        effect: ShimmerEffect(baseColor: shimmerColor),
        child: Card(
          color: cardColor,
          elevation: elevation,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.only(bottom: marginBottom),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'xxxxxx',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'xxxxxxxxxxx',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'xxxxxxxxxxxxxx',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'xxxxxxxxx',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppHelpers.stantingColor('stanting'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: const EdgeInsets.all(4),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(radius: 10.r),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
