import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ortuImunisasiCardLoading() {
  return Card(
    color: Colors.white,
    elevation: 1,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      title: Text(
        'Riwayat Imunisasi',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      trailing: CupertinoActivityIndicator(radius: 6.6.r),
    ),
  );
}
