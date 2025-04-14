import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
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

  static IconData genderIcon(String gender) {
    return gender.toLowerCase() == 'laki-laki'
        ? MingCute.male_line
        : MingCute.female_line;
  }

  static Color genderColor(String gender) {
    return gender.toLowerCase() == 'laki-laki'
        ? AppColors.maleColor
        : AppColors.femaleColor;
  }

  static String ageYearAndMonth(DateTime birthDate) {
    DateTime now = DateTime.now();

    int year = now.year - birthDate.year;
    int month = now.month - birthDate.month;

    if (month < 0) {
      year--;
      month += 12;
    }

    return "$year Tahun $month Bulan";
  }

  static String panduanImage(String ageRange) {
    final imageName = ageRange.toLowerCase().replaceAll(' ', '');
    return '$imageName.jpg';
  }

  static String dayMonthYearFormat(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String monthYearFormat(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String databaseDateFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatDoubleToString(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }
}
