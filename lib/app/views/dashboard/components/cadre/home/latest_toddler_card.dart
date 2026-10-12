import 'package:flutter/material.dart';

class LatestToddlerCard extends StatelessWidget {
  const new({
    required this.todddlerMonthAge,
    required this.toddlerName,
    required this.toddlerGender,
    this.dataLength = 0,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final int todddlerMonthAge;
  final String toddlerName;
  final String toddlerGender;
  final int dataLength;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
            child: InkWell(
              onTap: onTap,
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
                              '$todddlerMonthAge Bulan',
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                toddlerName,
                                maxLines: 1,
                                overflow: .ellipsis,
                                style: const TextStyle(
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
                        toddlerGender,
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
        ),
        if (index != (dataLength - 1)) ...[const SizedBox(width: 10)],
      ],
    );
  }
}
