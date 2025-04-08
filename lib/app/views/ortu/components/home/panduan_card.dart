import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PanduanCard extends StatelessWidget {
  const PanduanCard({
    required this.ageRange,
    this.index,
    this.dataLength,
    this.onTap,
    super.key,
  });

  final String ageRange;
  final int? index;
  final int? dataLength;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 136.w,
          child: Card(
            color: Colors.white,
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            margin: const EdgeInsets.only(bottom: 2),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                            '${AppStrings.assetsImages}/kia/${AppHelpers.panduanImage(ageRange)}',
                            width: 136.w,
                            fit: BoxFit.cover,
                          ),
                          Container(color: Colors.black.withValues(alpha: 0.2)),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Perawatan Bayi\nUsia',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              ageRange,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox.expand(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: onTap),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (index != ((dataLength ?? 0) - 1)) const SizedBox(width: 10),
      ],
    );
  }
}
