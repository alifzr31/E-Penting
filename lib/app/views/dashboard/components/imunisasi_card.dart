import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class ImunisasiCard extends StatelessWidget {
  const ImunisasiCard({
    required this.day,
    required this.date,
    required this.name,
    this.cardColor = Colors.white,
    this.elevation = 1,
    this.marginBottom = 10,
    this.index,
    this.dataLength,
    this.onTap,
    super.key,
  });

  final String day;
  final String date;
  final String name;
  final Color? cardColor;
  final double elevation;
  final double marginBottom;
  final int? index;
  final int? dataLength;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.only(
        bottom: index == ((dataLength ?? 0) - 1) ? 0 : marginBottom,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    date,
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
                    name,
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
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E6FC),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    MingCute.right_line,
                    size: 20.sp,
                    color: AppColors.blueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
