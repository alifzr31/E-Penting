import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';

class LatestImmunizationCardLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: Column(
        children: List.generate(5, (index) {
          return SafeArea(
            top: false,
            bottom: index == 4 ? true : false,
            child: Card(
              elevation: 1,
              color: Colors.white,
              clipBehavior: .antiAlias,
              margin: index == 4 ? .zero : const .only(bottom: 10),
              shape: RoundedRectangleBorder(borderRadius: .circular(10)),
              child: Padding(
                padding: const .all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          const Text(
                            'XXXXXXXXXXXXXXXXXXXXXXXX',
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: TextStyle(fontSize: 14, fontWeight: .w500),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'XXXXXX, XXXXXXXXXXX',
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
                    Container(
                      height: 28,
                      width: 28,
                      foregroundDecoration: const BoxDecoration(
                        shape: .circle,
                        color: AppColors.softBlueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
