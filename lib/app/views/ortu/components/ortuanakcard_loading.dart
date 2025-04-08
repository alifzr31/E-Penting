import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget ortuAnakCardLoading() {
  return Skeletonizer(
    child: Card(
      color: Colors.white,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          foregroundDecoration: BoxDecoration(
            color: Colors.indigo.shade100,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(radius: 20.r),
        ),
        title: Text(
          'xxxxxxxxxxxxxxxxxxxxxxxx',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          'xxxxxxxxxxxxxxxx',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    ),
  );
}
