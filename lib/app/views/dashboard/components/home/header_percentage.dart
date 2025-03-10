import 'package:epenting/app/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderPercentage extends StatelessWidget {
  const HeaderPercentage({
    required this.maleTotal,
    required this.femaleTotal,
    super.key,
  });

  final int maleTotal;
  final int femaleTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (maleTotal + femaleTotal).toString(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                'Balita Terdata',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: AspectRatio(
            aspectRatio: 2,
            child: PieChart(
              PieChartData(
                startDegreeOffset: 72,
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: [
                  PieChartSectionData(
                    color: AppColors.maleColor,
                    value: (maleTotal / (maleTotal + femaleTotal)) * 100,
                    showTitle: false,
                    radius: 28.r,
                  ),
                  PieChartSectionData(
                    color: AppColors.femaleColor,
                    value: (femaleTotal / (maleTotal + femaleTotal)) * 100,
                    showTitle: false,
                    radius: 28.r,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 8.r,
                    width: 8.r,
                    decoration: BoxDecoration(
                      color: AppColors.femaleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '${((femaleTotal / (maleTotal + femaleTotal)) * 100).toInt()}% Perempuan',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 8.r,
                    width: 8.r,
                    decoration: BoxDecoration(
                      color: AppColors.maleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '${((maleTotal / (maleTotal + femaleTotal)) * 100).toInt()}% Laki-laki',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
