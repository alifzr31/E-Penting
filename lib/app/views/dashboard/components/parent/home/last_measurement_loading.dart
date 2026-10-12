import 'package:e_penting/app/views/dashboard/components/parent/home/last_measurement_card.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LastMeasurementLoading extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseSkeletonizer(
      child: Column(
        children: [
          Row(
            children: [
              LastMeasurementCard(
                bgColor: Colors.green.shade100,
                icon: RemixIcon.dashboard3Line,
                iconColor: Colors.green.shade600,
                label: 'Berat\nBadan',
                value: 'XX kg',
              ),
              const SizedBox(width: 10),
              LastMeasurementCard(
                bgColor: Colors.blue.shade100,
                icon: RemixIcon.expandVerticalLine,
                iconColor: Colors.blue.shade600,
                label: 'Tinggi\nBadan',
                value: 'XX cm',
              ),
              const SizedBox(width: 10),
              LastMeasurementCard(
                bgColor: Colors.orange.shade100,
                icon: RemixIcon.expandDiagonalLine,
                iconColor: Colors.orange.shade600,
                label: 'Lingkar\nKepala',
                value: 'XX cm',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Skeleton.keep(
                child: Text(
                  'Pengukuran Terakhir :',
                  style: TextStyle(fontSize: 12),
                ),
              ),
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
