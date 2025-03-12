import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget imunisasiCardLoading(
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
    padding: withPadding ? const EdgeInsets.all(16) : EdgeInsets.zero,
    physics: const NeverScrollableScrollPhysics(),
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
                Column(
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
                SizedBox(width: 10.w),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'xxxxxxxxxxxxxxx',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
