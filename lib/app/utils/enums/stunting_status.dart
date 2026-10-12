import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart' show Color, Colors;

enum StuntingStatus {
  veryShort(label: 'Sangat Pendek', color: AppColors.veryShortColor),
  short(label: 'Pendek', color: AppColors.shortColor),
  normal(label: 'Normal', color: AppColors.normalColor),
  tall(label: 'Tinggi', color: AppColors.tallColor),
  unknown(label: 'Tidak Diketahui', color: Colors.grey);

  final String label;
  final Color color;

  new({required this.label, required this.color});

  factory StuntingStatus.fromString(String? value) {
    if (value == null || value.isEmpty) return StuntingStatus.unknown;

    final normalized = value.toLowerCase().trim();

    if (normalized.contains('sangat pendek')) {
      return StuntingStatus.veryShort;
    } else if (normalized.contains('pendek')) {
      return StuntingStatus.short;
    } else if (normalized.contains('normal')) {
      return StuntingStatus.normal;
    } else if (normalized.contains('tinggi')) {
      return StuntingStatus.tall;
    }

    return StuntingStatus.unknown;
  }
}
