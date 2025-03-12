import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseLoadScroll extends StatelessWidget {
  const BaseLoadScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Card(
          color: Colors.white,
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          shape: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Memuat data',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 6.w),
                CupertinoActivityIndicator(radius: 6.r),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
