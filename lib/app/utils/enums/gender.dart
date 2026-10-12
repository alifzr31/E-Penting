import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

enum Gender {
  male(label: 'Laki-laki', color: AppColors.maleColor, icon: RemixIcon.menLine),
  female(
    label: 'Perempuan',
    color: AppColors.femaleColor,
    icon: RemixIcon.womenLine,
  ),
  unknown(
    label: 'Tidak Diketahui',
    color: Colors.black87,
    icon: RemixIcon.questionLine,
  );

  factory Gender.fromApi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Gender.unknown;
    }

    return Gender.values.firstWhere(
      (element) => element.label.toLowerCase() == value.trim().toLowerCase(),
      orElse: () => Gender.unknown,
    );
  }

  String toApi() => label;

  static List<Gender> get filteredValues => values.where((element) {
    return element.name != 'unknown';
  }).toList();

  final String label;
  final Color color;
  final IconData icon;

  const new({required this.label, required this.color, required this.icon});
}
