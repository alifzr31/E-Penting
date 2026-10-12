import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';

class ImmunizationHistoryLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: ListView(
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(2, (index) {
          return IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      foregroundDecoration: const BoxDecoration(
                        shape: .circle,
                        color: AppColors.maleColor,
                      ),
                    ),
                    if (index != 1) ...[
                      Expanded(
                        child: Container(
                          width: 2,
                          foregroundDecoration: const BoxDecoration(
                            color: AppColors.maleColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    height: 84,
                    width: .infinity,
                    margin: const .only(bottom: 8),
                    foregroundDecoration: const BoxDecoration(
                      color: AppColors.maleColor,
                      borderRadius: .directional(
                        topStart: .circular(4),
                        topEnd: .circular(8),
                        bottomEnd: .circular(4),
                        bottomStart: .circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
