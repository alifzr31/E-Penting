import 'package:epenting/app/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuImunisasiCard extends StatelessWidget {
  const OrtuImunisasiCard({
    required this.imunisasiDate,
    required this.latestVaccines,
    this.index,
    this.dataLength,
    super.key,
  });

  final DateTime imunisasiDate;
  final List<String> latestVaccines;
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
              Container(height: 72.r, width: 1, color: const Color(0xFF96C7FF)),
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
                      AppHelpers.dayMonthYearFormat(imunisasiDate),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: List.generate(latestVaccines.length, (idx) {
                        final vaccine = latestVaccines[idx];

                        return TextSpan(
                          text:
                              idx == (latestVaccines.length - 1)
                                  ? vaccine
                                  : '$vaccine, ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        );
                      }),
                    ),
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
