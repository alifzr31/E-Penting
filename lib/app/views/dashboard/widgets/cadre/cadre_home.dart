import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/stat/stat_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/home/cadre_home_header_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/home/cadre_home_latest_immunization_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/home/cadre_home_latest_measurement_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/home/cadre_home_latest_toddler_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/home/cadre_home_toddler_gender_section.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreHome extends StatefulWidget {
  const new({
    required this.scaffoldKey,
    this.onSeeAllToddler,
    this.onSeeAllMeasurement,
    this.onSeeAllImmunization,
    super.key,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback? onSeeAllToddler;
  final VoidCallback? onSeeAllMeasurement;
  final VoidCallback? onSeeAllImmunization;

  @override
  State<CadreHome> createState() => _CadreHomeState();
}

class _CadreHomeState extends State<CadreHome> {
  Future<void> _initHomeData() async {
    final statCubit = context.read<StatCubit>();
    final toddlerCubit = context.read<ToddlerCubit>();
    final measurementCubit = context.read<MeasurementCubit>();
    final immunizationCubit = context.read<ImmunizationCubit>();

    await statCubit.fetchPercentage();
    await toddlerCubit.fetchLatestToddlers();
    await measurementCubit.fetchLatestMeasurements();
    await immunizationCubit.fetchLatestImmunizations();
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () async {
      if (!mounted) return;

      final statCubit = context.read<StatCubit>();
      final toddlerCubit = context.read<ToddlerCubit>();
      final measurementCubit = context.read<MeasurementCubit>();
      final immunizationCubit = context.read<ImmunizationCubit>();

      statCubit.refetchPercentage();
      toddlerCubit.refetchLatestToddlers();
      measurementCubit.refetchLatestMeasurements();
      immunizationCubit.refetchLatestImmunizations();
    });
  }

  @override
  void initState() {
    super.initState();
    _initHomeData();
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
          CadreHomeHeaderSection(scaffoldKey: widget.scaffoldKey),
          const SizedBox(height: 16),
          const CadreHomeToddlerGenderSection(),
          const SizedBox(height: 16),
          CadreHomeLatestToddlerSection(
            onSeeAllToddler: widget.onSeeAllToddler,
          ),
          const SizedBox(height: 16),
          CadreHomeLatestMeasurementSection(
            onSeeAllMeasurement: widget.onSeeAllMeasurement,
          ),
          const SizedBox(height: 16),
          CadreHomeLatestImmunizationSection(
            onSeeAllImmunization: widget.onSeeAllImmunization,
          ),
        ],
      ),
    );
  }
}
