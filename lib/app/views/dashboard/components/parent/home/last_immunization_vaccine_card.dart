import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';

class LastImmunizationVaccineCard extends StatelessWidget {
  const new({required this.vaccineName, super.key});

  final String vaccineName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: .zero,
      clipBehavior: .antiAlias,
      color: AppColors.softBlueColor,
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      child: Padding(
        padding: const .symmetric(vertical: 4, horizontal: 10),
        child: Center(
          child: Text(
            vaccineName,
            textAlign: .center,
            maxLines: 1,
            overflow: .ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: .w500,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ),
    );
  }
}
