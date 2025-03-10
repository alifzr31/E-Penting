import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppHelpers {
  static Color stantingColor(String? stanting) {
    return (stanting?.toLowerCase().contains('sangat pendek') ?? false)
        ? AppColors.veryShortColor
        : (stanting?.toLowerCase().contains('pendek') ?? false)
        ? AppColors.shortColor
        : stanting?.toLowerCase() == 'tinggi'
        ? AppColors.tallColor
        : AppColors.normalColor;
  }

  static String monthYearFormat(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }
}
