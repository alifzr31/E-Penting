import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class GuideCard extends StatelessWidget {
  const new({
    required this.guide,
    this.dataLength = 0,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final String guide;
  final int dataLength;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 200,
          width: 150,
          child: Card(
            elevation: 1,
            color: Colors.white,
            margin: const .only(bottom: 2),
            clipBehavior: .antiAlias,
            shape: RoundedRectangleBorder(borderRadius: .circular(10)),
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Expanded(
                    child: Ink(
                      width: .infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: .topCenter,
                          fit: .cover,
                          image: Image.asset(
                            '${AppStrings.assetsImages}/kia/${guide.guideImage()}',
                          ).image,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: .centerLeft,
                    child: Padding(
                      padding: const .symmetric(vertical: 10, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          const Text(
                            'Perawatan Bayi Usia',
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            guide,
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: .w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (index != (dataLength - 1)) const SizedBox(width: 10),
      ],
    );
  }
}
