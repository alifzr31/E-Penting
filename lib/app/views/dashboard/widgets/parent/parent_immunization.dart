import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/models/vaccine.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/immunization/parent_administered_immunization_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/immunization/parent_immunization_history_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_child_section.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentImmunization extends StatefulWidget {
  const new({this.isActive = true, super.key});

  final bool isActive;

  @override
  State<ParentImmunization> createState() => _ParentImmunizationState();
}

class _ParentImmunizationState extends State<ParentImmunization> {
  final vaccinesMap = const [
    {'label': "HB", 'id': "hb"},
    {'label': "DPT-HB 1", 'id': "dpthb1"},
    {'label': "DPT-HB 2", 'id': "dpthb2"},
    {'label': "DPT-HB 3", 'id': "dpthb3"},
    {'label': "DPT-HB L", 'id': "dpthbl"},
    {'label': "Polio 1", 'id': "polio1"},
    {'label': "Polio 2", 'id': "polio2"},
    {'label': "Polio 3", 'id': "polio3"},
    {'label': "Polio 4", 'id': "polio4"},
    {'label': "Campak", 'id': "campak"},
    {'label': "Campak L", 'id': "campakl"},
    {'label': "BCG", 'id': "bcg"},
    {'label': "IPV 1", 'id': "ipv1"},
    {'label': "IPV 2", 'id': "ipv2"},
    {'label': "ROTAV 1", 'id': "rotav1"},
    {'label': "ROTAV 2", 'id': "rotav2"},
    {'label': "ROTAV 3", 'id': "rotav3"},
    {'label': "PCV 1", 'id': "pcv1"},
    {'label': "PCV 2", 'id': "pcv2"},
    {'label': "PCV 3", 'id': "pcv3"},
  ];
  final List<Vaccine> _vaccines = [];

  Future<void> _initImmunizationData() async {
    for (var element in vaccinesMap) {
      final id = element['id'] ?? '';
      final label = element['label'] ?? '';

      _vaccines.add(Vaccine(id: id, label: label));
    }
    setState(() {});

    final selectedChild = context.read<SelectedChildCubit>().state;

    context.read<ImmunizationCubit>().fetchImmunizationHistoryNik(
      nik: selectedChild?.nik,
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final immunizationCubit = context.read<ImmunizationCubit>();
      final selectedChild = context.read<SelectedChildCubit>().state;

      immunizationCubit.refetchImmunizationHistoryNik(nik: selectedChild?.nik);
    });
  }

  @override
  void initState() {
    super.initState();
    _initImmunizationData();
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
          ParentAdministeredImmunizationSection(vaccines: _vaccines),
          const SizedBox(height: 16),
          const ParentImmunizationHistorySection(),
        ],
      ),
    );
  }
}
