import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LastMeasurementCard extends StatelessWidget {
  const new({
    required this.bgColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    super.key,
  });

  final Color bgColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        clipBehavior: .antiAlias,
        borderRadius: .circular(8),
        color: bgColor,
        child: Padding(
          padding: const .all(10),
          child: Column(
            children: [
              Skeleton.keep(child: Icon(icon, size: 32, color: iconColor)),
              const SizedBox(height: 6),
              Skeleton.keep(
                child: Text(
                  label,
                  textAlign: .center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                textAlign: .center,
                style: const TextStyle(fontSize: 14, fontWeight: .w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
