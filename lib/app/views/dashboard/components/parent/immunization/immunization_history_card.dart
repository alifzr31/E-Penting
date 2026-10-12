import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class ImmunizationHistoryCard extends StatelessWidget {
  const new({
    required this.immunizationDate,
    required this.vaccines,
    this.dataLength = 0,
    this.index = 0,
    super.key,
  });

  final DateTime? immunizationDate;
  final List<String> vaccines;
  final int dataLength;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                  shape: .circle,
                  color: AppColors.maleColor,
                ),
              ),
              if (index != (dataLength - 1)) ...[
                Expanded(
                  child: Container(width: 2, color: AppColors.maleColor),
                ),
              ],
            ],
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Card(
              elevation: 0,
              clipBehavior: .antiAlias,
              color: AppColors.maleColor,
              margin: .only(bottom: index == (dataLength - 1) ? 0 : 8),
              shape: const RoundedRectangleBorder(
                borderRadius: .directional(
                  topStart: .circular(4),
                  topEnd: .circular(8),
                  bottomEnd: .circular(4),
                  bottomStart: .circular(8),
                ),
              ),
              child: Padding(
                padding: const .all(8),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      immunizationDate == null
                          ? 'Tanggal tidak diketahui'
                          : immunizationDate!.dayMonthYear(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      vaccines.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: .w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
