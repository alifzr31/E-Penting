import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:flutter/material.dart';

class ToddlerCard extends StatelessWidget {
  const new({
    required this.toddlerGender,
    required this.toddlerName,
    required this.toddlerNumber,
    required this.toddlerMonthAge,
    required this.toddlerHeight,
    required this.toddlerWeight,
    this.dataLength = 0,
    this.index = 0,
    this.onTap,
    super.key,
  });

  final String? toddlerGender;
  final String toddlerName;
  final int toddlerNumber;
  final int toddlerMonthAge;
  final double toddlerHeight;
  final double toddlerWeight;
  final int dataLength;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      margin: index == (dataLength - 1) ? .zero : const .only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const .all(16),
          child: Row(
            children: [
              Ink(
                padding: const .all(6),
                decoration: BoxDecoration(
                  shape: .circle,
                  color: Gender.fromApi(toddlerGender).color,
                ),
                child: Center(
                  child: Icon(
                    Gender.fromApi(toddlerGender).icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: .centerLeft,
                      child: Text(
                        toddlerName,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: const TextStyle(fontSize: 14, fontWeight: .w500),
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
                                'Anak ke-$toddlerNumber',
                                maxLines: 1,
                                overflow: .ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                '$toddlerMonthAge Bulan',
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
                                'Tinggi lahir $toddlerHeight cm',
                                textAlign: .right,
                                maxLines: 1,
                                overflow: .ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                'Berat lahir $toddlerWeight kg',
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
      ),
    );
  }
}
