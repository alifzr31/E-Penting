import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/growth/height_measurement_graph.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/growth/weight_measurement_graph.dart';
import 'package:flutter/material.dart';

class ParentMeasurementGraphSection extends StatefulWidget {
  const new({super.key});

  @override
  State<ParentMeasurementGraphSection> createState() =>
      _ParentMeasurementGraphSectionState();
}

class _ParentMeasurementGraphSectionState
    extends State<ParentMeasurementGraphSection> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _currentTab,
      child: Padding(
        padding: const .symmetric(horizontal: 16),
        child: SizedBox(
          width: .infinity,
          child: Material(
            elevation: 1,
            color: Colors.white,
            clipBehavior: .antiAlias,
            borderRadius: .circular(10),
            child: Column(
              children: [
                TabBar(
                  padding: .zero,
                  dividerHeight: 1,
                  indicatorPadding: .zero,
                  labelPadding: const .symmetric(vertical: 8),
                  indicatorWeight: 1,
                  indicatorSize: .tab,
                  indicatorColor: AppColors.orangeColor,
                  labelStyle: const TextStyle(fontSize: 14, fontWeight: .w600),
                  labelColor: AppColors.orangeColor,
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  unselectedLabelColor: Colors.grey.shade600,
                  dividerColor: AppColors.orangeColor.withValues(alpha: 0.3),
                  onTap: (index) {
                    setState(() {
                      _currentTab = index;
                    });
                  },
                  tabs: const [Text('Tinggi Badan'), Text('Berat Badan')],
                ),
                const SizedBox(
                  height: 300,
                  width: .infinity,
                  child: TabBarView(
                    clipBehavior: .antiAlias,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HeightMeasurementGraph(),
                      WeightMeasurementGraph(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
