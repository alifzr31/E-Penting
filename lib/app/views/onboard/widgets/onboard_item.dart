import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardItem extends StatelessWidget {
  const OnboardItem({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: SvgPicture.asset(image),
          ),
          SizedBox(height: 30.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
