import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomBottomSheet(
  BuildContext context, {
  double? height,
  Widget? child,
}) {
  showModalBottomSheet(
    clipBehavior: Clip.antiAlias,
    elevation: 2,
    isDismissible: false,
    isScrollControlled: false,
    backgroundColor: AppColors.scaffoldBgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 8,
                    width: ScreenUtil().screenWidth * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 15), child: child),
            ],
          ),
        ),
      );
    },
  );
}
