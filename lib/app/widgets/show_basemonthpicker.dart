import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

Future<DateTime?> showBaseMonthPicker(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(DateTime)? selectableMonthPredicate,
  bool Function(int)? selectableYearPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
}) {
  return showMonthPicker(
    context: context,
    firstDate: firstDate,
    lastDate: lastDate,
    initialDate: initialDate,
    selectableMonthPredicate: selectableMonthPredicate,
    selectableYearPredicate: selectableYearPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    headerTitle: Text(
      'Pilih Bulan',
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    monthPickerDialogSettings: MonthPickerDialogSettings(
      dialogSettings: PickerDialogSettings(
        dialogBackgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        dialogRoundedCornersRadius: 10.r,
        dismissible: true,
        locale: Locale('id', 'ID'),
      ),
      headerSettings: PickerHeaderSettings(
        headerBackgroundColor: AppColors.blueColor,
        headerCurrentPageTextStyle: TextStyle(color: Colors.white),
      ),
      dateButtonsSettings: PickerDateButtonsSettings(
        currentMonthTextColor: AppColors.orangeColor,
        selectedMonthBackgroundColor: const Color(0xFFE2E6FC),
        selectedMonthTextColor: AppColors.blueColor,
        unselectedMonthsTextColor: Colors.black,
        monthTextStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      actionBarSettings: PickerActionBarSettings(
        confirmWidget: Text(
          'Pilih Bulan',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blueColor,
          ),
        ),
        cancelWidget: Text(
          'Batal',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.indigo.shade400,
          ),
        ),
      ),
    ),
  );
}
