import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdministeredImmunizationLoading extends StatelessWidget {
  const new({required this.dataLength, super.key});

  final int dataLength;

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: Column(
        children: [
          GridView(
            shrinkWrap: true,
            padding: .zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 6,
            ),
            children: List.generate(dataLength, (index) {
              return Container(
                foregroundDecoration: BoxDecoration(
                  color: AppColors.softBlueColor,
                  borderRadius: .circular(6),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Skeleton.keep(
                child: Text(
                  'Terakhir Diperbarui :',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: .centerRight,
                  child: Text(
                    'XXXXXXXXXXXXXXXXX',
                    textAlign: .right,
                    style: TextStyle(fontSize: 12, fontWeight: .w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
