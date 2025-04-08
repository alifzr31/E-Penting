import 'package:epenting/app/models/profile.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class AnakChoiceItem extends StatelessWidget {
  const AnakChoiceItem({
    required this.selectedAnak,
    required this.anakItem,
    this.onSelectedAnak,
    super.key,
  });

  final Anak? selectedAnak;
  final Anak? anakItem;
  final void Function()? onSelectedAnak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: selectedAnak == anakItem ? 10 : 0,
      ),
      child: ListTile(
        dense: true,
        tileColor:
            selectedAnak == anakItem
                ? AppColors.orangeColor.withValues(alpha: 0.2)
                : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(
          backgroundColor: AppHelpers.genderColor('laki-laki'),
          radius: 20.r,
          child: Center(
            child: Icon(
              AppHelpers.genderIcon('laki-laki'),
              size: 24.r,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          anakItem?.nama ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          AppHelpers.ageYearAndMonth(anakItem?.tanggalLahir ?? DateTime(0000)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        trailing:
            selectedAnak == anakItem
                ? Icon(
                  MingCute.check_circle_fill,
                  size: 18.sp,
                  color: AppColors.orangeColor,
                )
                : null,
        onTap: selectedAnak == anakItem ? null : onSelectedAnak,
      ),
    );
  }
}
