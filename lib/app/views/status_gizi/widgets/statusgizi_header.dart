import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class StatusGiziHeader extends StatelessWidget {
  const StatusGiziHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Material(
            color: Colors.white,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: BaseIconButton(
                  icon: MingCute.arrow_left_line,
                  size: 20.sp,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Material(
              color: Colors.white,
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              shape: const StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Cek Status Gizi Anak',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Material(
            color: Colors.white,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: Icon(MingCute.dashboard_line, size: 20.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
