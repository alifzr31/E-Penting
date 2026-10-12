import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';

class LatestToddlerLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: ListView.builder(
        scrollDirection: .horizontal,
        padding: const .symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                height: 94,
                width: 180,
                child: Card(
                  elevation: 1,
                  margin: const .symmetric(vertical: 2),
                  color: Colors.white,
                  clipBehavior: .antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: .circular(8)),
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: .centerLeft,
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  'XX Bulan',
                                  maxLines: 1,
                                  overflow: .ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const Flexible(
                                  child: Text(
                                    'XXXXXXXXXXXXXXXXXX',
                                    maxLines: 1,
                                    overflow: .ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: .w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: .centerLeft,
                          child: Text(
                            'XXXXXXXXX',
                            maxLines: 1,
                            overflow: .ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          );
        },
      ),
    );
  }
}
