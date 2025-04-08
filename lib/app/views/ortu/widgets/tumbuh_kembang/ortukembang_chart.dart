import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuKembangChart extends StatelessWidget {
  const OrtuKembangChart({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          color: Colors.white,
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(10.r),
          child: Column(
            children: [
              TabBar(
                labelColor: AppColors.orangeColor,
                indicatorColor: AppColors.orangeColor,
                dividerHeight: 1,
                dividerColor: Theme.of(context).colorScheme.primaryContainer,
                labelPadding: const EdgeInsets.symmetric(vertical: 10),
                tabs: [
                  Text(
                    'Tinggi Badan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Berat Badan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 240.h,
                width: double.infinity,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(2, (index) {
                    return Center(
                      child: Text(
                        'Under Maintenance',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
