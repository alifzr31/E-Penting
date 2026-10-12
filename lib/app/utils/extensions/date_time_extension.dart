import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dayMonthYear() {
    return DateFormat('dd MMMM yyyy').format(this);
  }

  String monthYear() {
    return DateFormat('MMMM yyyy').format(this);
  }

  String formDataFormat() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String ageYearMonth() {
    final now = DateTime.now();

    int years = now.year - year;
    int months = now.month - month;

    if (now.day < day) {
      months--;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    return '$years Tahun $months Bulan';
  }
}
