import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class VaccineCard extends StatelessWidget {
  const VaccineCard({required this.name, required this.isMatch, super.key});

  final String name;
  final bool isMatch;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: isMatch ? const Color(0xFFC6E1FF) : const Color(0xFFFFEDEB),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isMatch ? MingCute.check_line : MingCute.close_line,
              size: 14.sp,
              color:
                  isMatch ? const Color(0xFF2D70D3) : const Color(0xFFDF736F),
            ),
            SizedBox(width: 2.w),
            Flexible(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color:
                      isMatch
                          ? const Color(0xFF2D70D3)
                          : const Color(0xFFDF736F),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
