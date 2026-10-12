import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';
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
    headerTitle: const Text(
      'Pilih Bulan',
      style: TextStyle(fontSize: 18, fontWeight: .w600, color: Colors.white),
    ),
    monthPickerDialogSettings: MonthPickerDialogSettings(
      dialogSettings: const PickerDialogSettings(
        dialogBackgroundColor: Colors.white,
        insetPadding: .all(10),
        gridPadding: .zero,
        dialogRoundedCornersRadius: 10,
        dismissible: true,
        locale: Locale('id', 'ID'),
      ),
      headerSettings: const PickerHeaderSettings(
        titleSpacing: 0,
        headerBackgroundColor: AppColors.blueColor,
        headerCurrentPageTextStyle: TextStyle(color: Colors.white),
      ),
      dateButtonsSettings: PickerDateButtonsSettings(
        currentMonthTextColor: AppColors.blueColor,
        selectedMonthBackgroundColor: AppColors.blueColor.withValues(
          alpha: 0.1,
        ),
        selectedMonthTextColor: AppColors.blueColor,
        unselectedMonthsTextColor: Colors.black,
        selectedDateRadius: 10,
        monthTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: .w500,
          fontFamily: 'Poppins',
        ),
      ),
      actionBarSettings: PickerActionBarSettings(
        actionBarPadding: const .only(right: 10, bottom: 10),
        buttonSpacing: 10,
        confirmWidget: const Text(
          'Pilih Bulan',
          style: TextStyle(
            fontSize: 12,
            fontWeight: .w500,
            color: AppColors.orangeColor,
          ),
        ),
        cancelWidget: Text(
          'Batal',
          style: TextStyle(
            fontSize: 12,
            fontWeight: .w500,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    ),
  );
}
