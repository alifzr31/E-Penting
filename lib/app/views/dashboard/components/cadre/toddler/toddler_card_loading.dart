import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';

class ToddlerCardLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: ListView.builder(
        padding: const .only(top: 4, left: 16, right: 16, bottom: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            color: Colors.white,
            clipBehavior: .antiAlias,
            shape: RoundedRectangleBorder(borderRadius: .circular(10)),
            margin: const .only(bottom: 10),
            child: Padding(
              padding: const .all(16),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    foregroundDecoration: const BoxDecoration(
                      shape: .circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Align(
                          alignment: .centerLeft,
                          child: Text(
                            'XXXXXXXXXXXXXXXXXXXXXXXX',
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: TextStyle(fontSize: 14, fontWeight: .w500),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    'Anak ke-0',
                                    maxLines: 1,
                                    overflow: .ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    '00 Bulan',
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .end,
                                children: [
                                  Text(
                                    'Tinggi lahir 00 cm',
                                    textAlign: .right,
                                    maxLines: 1,
                                    overflow: .ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    'Berat lahir 00 kg',
                                    textAlign: .right,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
