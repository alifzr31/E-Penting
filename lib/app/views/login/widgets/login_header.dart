import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: 110.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
              ),
              Positioned(
                top: 58.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        '${AppStrings.assetsImages}/logo2.svg',
                        width: 94.r,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'E-Penting',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
