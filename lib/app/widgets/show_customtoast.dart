import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

void showCustomToast(
  BuildContext context, {
  ToastificationType? type,
  String? title,
  String? description,
}) {
  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flat,
    title: Text(
      title ?? '',
      maxLines: description == null ? 99 : 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
    ),
    description:
        description == null
            ? null
            : Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.sp),
            ),
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 5),
    borderRadius: BorderRadius.circular(10.r),
    boxShadow: lowModeShadow,
    progressBarTheme: ProgressIndicatorThemeData(
      color: AppColors.blueColor,
      linearTrackColor: AppColors.softBlueColor,
      borderRadius: BorderRadius.circular(4.r),
    ),
    dragToClose: true,
    closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  );
}
