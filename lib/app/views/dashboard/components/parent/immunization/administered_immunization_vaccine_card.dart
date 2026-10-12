import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class AdministeredImmunizationVaccineCard extends StatelessWidget {
  const new({required this.vaccineName, required this.isMatched, super.key});

  final String vaccineName;
  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: .zero,
      clipBehavior: .antiAlias,
      color: isMatched ? AppColors.softBlueColor : null,
      shape: RoundedRectangleBorder(borderRadius: .circular(6)),
      child: Padding(
        padding: const .symmetric(vertical: 4, horizontal: 10),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Icon(
              isMatched
                  ? RemixIcon.checkboxCircleLine
                  : RemixIcon.closeCircleLine,
              size: 16,
              color: isMatched ? AppColors.blueColor : AppColors.orangeColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                vaccineName,
                textAlign: .center,
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: .w500,
                  color: isMatched
                      ? AppColors.blueColor
                      : AppColors.orangeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
