import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ToddlerGenderGraphLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: Row(
        children: [
          const Expanded(
            child: Skeleton.keep(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Balita',
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                  Text(
                    'Terdata',
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 100,
            width: 100,
            foregroundDecoration: const BoxDecoration(
              shape: .circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: .circle,
                            color: AppColors.maleColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Flexible(
                          child: Skeleton.keep(
                            child: Text(
                              'Laki-laki',
                              textAlign: .right,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Align(
                      alignment: .centerRight,
                      child: Text(
                        'XXX%',
                        textAlign: .right,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: .w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: .circle,
                            color: AppColors.femaleColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Flexible(
                          child: Skeleton.keep(
                            child: Text(
                              'Perempuan',
                              textAlign: .right,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Align(
                      alignment: .centerRight,
                      child: Text(
                        'XXX%',
                        textAlign: .right,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: .w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
