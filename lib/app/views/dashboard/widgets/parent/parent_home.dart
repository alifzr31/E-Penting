import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/home/parent_guide_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/home/parent_last_immunization_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/home/parent_last_measurement_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_child_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_header_section.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentHome extends StatefulWidget {
  const new({
    required this.scaffoldKey,
    this.isActive = true,
    this.onSeeMeasurementHistory,
    this.onSeeImmunizationHistory,
    super.key,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isActive;
  final VoidCallback? onSeeMeasurementHistory;
  final VoidCallback? onSeeImmunizationHistory;

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  final _guides = const [
    '29 Hari - 3 Bulan',
    '3 - 6 Bulan',
    '6 - 9 Bulan',
    '9 - 12 Bulan',
    '12 - 18 Bulan',
    '18 - 24 Bulan',
    '2 - 3 Tahun',
    '3 - 4 Tahun',
    '4 - 5 Tahun',
    '5 - 6 Tahun',
  ];

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final toddlerCubit = context.read<ToddlerCubit>();
      final selectedChild = context.read<SelectedChildCubit>().state;

      toddlerCubit.refetchToodlerLatestNik(nik: selectedChild?.nik);
    });
  }

  @override
  void initState() {
    super.initState();
    final selectedChild = context.read<SelectedChildCubit>().state;

    context.read<ToddlerCubit>().fetchToodlerLatestNik(nik: selectedChild?.nik);
  }

  @override
  Widget build(BuildContext context) {
    return BaseRefreshIndicator(
      displacement: context.deviceViewPadding.top + 16,
      onRefresh: _onRefresh,
      child: ListView(
        padding: .zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ParentHeaderSection(scaffoldKey: widget.scaffoldKey),
          const SizedBox(height: 16),
          ParentChildSection(
            isActive: widget.isActive,
            topSafeArea: false,
            padding: const .symmetric(horizontal: 16),
          ),
          const SizedBox(height: 16),
          ParentLastMeasurementSection(
            onSeeHistory: widget.onSeeMeasurementHistory,
          ),
          const SizedBox(height: 16),
          ParentLastImmunizationSection(
            onSeeHistory: widget.onSeeImmunizationHistory,
          ),
          const SizedBox(height: 16),
          ParentGuideSection(guides: _guides),
        ],
      ),
    );
  }
}
