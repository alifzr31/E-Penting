import 'package:epenting/app/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class HistoryPengukuranCard extends StatelessWidget {
  const HistoryPengukuranCard({
    required this.pengukuranDate,
    required this.weight,
    required this.height,
    this.index,
    this.dataLength,
    super.key,
  });

  final DateTime pengukuranDate;
  final double weight;
  final double height;
  final int? index;
  final int? dataLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(radius: 8.r, backgroundColor: const Color(0xFF80B4FF)),
            if (index != ((dataLength ?? 0) - 1)) SizedBox(height: 4.h),
            if (index != ((dataLength ?? 0) - 1))
              Container(height: 36.r, width: 1, color: const Color(0xFF96C7FF)),
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
            margin: EdgeInsets.only(
              bottom: index == ((dataLength ?? 0) - 1) ? 4 : 8,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppHelpers.dayMonthYearFormat(pengukuranDate),
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
                            Icon(
                              MingCute.dashboard_3_line,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                '$weight kg',
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
                            Icon(
                              MingCute.fullscreen_2_line,
                              size: 14.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                '$height cm',
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
    );
  }
}
