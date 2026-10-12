import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  final int decimalRange;

  DecimalInputFormatter({this.decimalRange = 2});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final regExp = RegExp('^\\d*\\.?\\d{0,$decimalRange}');
    final match = regExp.stringMatch(newValue.text);

    if (match == newValue.text) {
      return newValue;
    }

    return oldValue;
  }
}
