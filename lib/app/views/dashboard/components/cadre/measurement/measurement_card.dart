import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/enums/stunting_status.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class MeasurementCard extends StatelessWidget {
  const new({
    required this.toddlerName,
    required this.measurementDay,
    required this.measurementDate,
    required this.stuntingStatus,
    this.dataLength = 0,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final String toddlerName;
  final String measurementDay;
  final String measurementDate;
  final String stuntingStatus;
  final int dataLength;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      clipBehavior: .antiAlias,
      margin: index == (dataLength - 1) ? .zero : const .only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          toddlerName,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: .w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$measurementDay, $measurementDate',
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Ink(
                    padding: const .all(6),
                    decoration: const BoxDecoration(
                      shape: .circle,
                      color: AppColors.softBlueColor,
                    ),
                    child: const Icon(
                      RemixIcon.arrowRightWideLine,
                      size: 16,
                      color: AppColors.blueColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const .symmetric(vertical: 6),
                child: Divider(height: 6, color: Colors.grey.shade300),
              ),
              Ink(
                width: .infinity,
                padding: const .symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: StuntingStatus.fromString(stuntingStatus).color,
                  borderRadius: .circular(20),
                ),
                child: Center(
                  child: Text(
                    StuntingStatus.fromString(stuntingStatus).label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
