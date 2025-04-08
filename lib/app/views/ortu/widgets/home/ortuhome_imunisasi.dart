import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_emptystate.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuHomeImunisasi extends StatelessWidget {
  const OrtuHomeImunisasi({required this.imunisasiHistory, super.key});

  final void Function()? imunisasiHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Imunisasi Terakhir',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  BaseTextButton(
                    text: 'Lihat Riwayat',
                    size: 12.sp,
                    color: AppColors.orangeColor,
                    onPressed: imunisasiHistory,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BaseEmptyState(
                message: 'Belum ada imunisasi yang dilakukan :(',
                totalData: '0 Imunisasi',
                showButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
