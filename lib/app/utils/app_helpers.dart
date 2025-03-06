import 'package:flutter/material.dart';

class AppHelpers {
  static Color stantingColor(String? stanting) {
    return stanting?.toLowerCase() == 'sangat pendek'
        ? const Color(0xFFB3261E)
        : stanting?.toLowerCase() == 'pendek'
        ? const Color(0xFFC35C00)
        : stanting?.toLowerCase() == 'tinggi'
        ? const Color(0xFF2F6BBA)
        : const Color(0xFF2B7B50);
  }
}
