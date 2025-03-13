import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

class BaseErrorstate extends StatelessWidget {
  const BaseErrorstate({
    required this.message,
    this.messageSize,
    this.padding = EdgeInsets.zero,
    this.lottieWidth,
    this.showButton = true,
    this.onPressedRefresh,
    super.key,
  });

  final String message;
  final double? messageSize;
  final EdgeInsetsGeometry padding;
  final double? lottieWidth;
  final bool showButton;
  final void Function()? onPressedRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              '${AppStrings.assetsLotties}/empty.json',
              width: lottieWidth,
              frameRate: const FrameRate(144),
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: messageSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (showButton) SizedBox(height: 6.h),
            if (showButton)
              SizedBox(
                height: 30.h,
                width: double.infinity,
                child: BaseOutlineButtonIcon(
                  borderColor: AppColors.orangeColor,
                  fgColor: AppColors.orangeColor,
                  icon: MingCute.refresh_3_line,
                  label: 'Muat Ulang',
                  onPressed: onPressedRefresh,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BaseHorizontalErrorState extends StatelessWidget {
  const BaseHorizontalErrorState({
    required this.message,
    this.messageSize,
    this.lottieWidth,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final String message;
  final double? messageSize;
  final EdgeInsetsGeometry padding;
  final double? lottieWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            '${AppStrings.assetsLotties}/empty.json',
            width: lottieWidth,
            frameRate: const FrameRate(144),
          ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: messageSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
