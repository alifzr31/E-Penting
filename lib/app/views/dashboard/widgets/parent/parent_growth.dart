import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/growth/parent_measurement_graph_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/growth/parent_measurement_history_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_child_section.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentGrowth extends StatefulWidget {
  const new({this.isActive = true, super.key});

  final bool isActive;

  @override
  State<ParentGrowth> createState() => _ParentGrowthState();
}

class _ParentGrowthState extends State<ParentGrowth> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final measurementCubit = context.read<MeasurementCubit>();
      final selectedChild = context.read<SelectedChildCubit>().state;

      measurementCubit.refetchAllParentData(nik: selectedChild?.nik);
    });
  }

  @override
  void initState() {
    super.initState();
    final selectedChild = context.read<SelectedChildCubit>().state;

    context.read<MeasurementCubit>().fetchAllParentData(
      nik: selectedChild?.nik,
    );
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
          ParentChildSection(
            isActive: widget.isActive,
            padding: const .only(top: 16, left: 16, right: 16),
          ),
          const SizedBox(height: 16),
          const ParentMeasurementGraphSection(),
          const SizedBox(height: 16),
          const ParentMeasurementHistorySection(),
        ],
      ),
    );
  }
}
