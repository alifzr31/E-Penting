import 'dart:async' show Timer;

import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/immunization/cadre_immunization_header_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/immunization/cadre_immunization_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreImmunization extends StatefulWidget {
  const new({super.key});

  @override
  State<CadreImmunization> createState() => _CadreImmunizationState();
}

class _CadreImmunizationState extends State<CadreImmunization> {
  final _keywordController = TextEditingController();
  String? _keyword;
  Timer? _searchDebounce;
  DateTime? _selectedMonthYear;
  final _scrollController = ScrollController();

  Future<void> _initMeasurementData() async {
    _scrollController.addListener(_onScroll);

    final immunizationCubit = context.read<ImmunizationCubit>();

    await immunizationCubit.fetchImmunizations(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final hasMore = context.read<ImmunizationCubit>().state.hasMoreImmunization;

    if (currentScroll == maxScroll && hasMore) {
      context.read<ImmunizationCubit>().fetchImmunizations(
        month: _selectedMonthYear?.month,
        year: _selectedMonthYear?.year,
      );
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final immunizationCubit = context.read<ImmunizationCubit>();

      immunizationCubit.refetchImmunizations(
        keyword: _keyword,
        month: _selectedMonthYear?.month,
        year: _selectedMonthYear?.year,
      );
    });
  }

  void _onSearchImmunization(String? keyword) {
    _keyword = keyword;
    if (_selectedMonthYear != null) {
      _selectedMonthYear = null;
    }
    setState(() {});

    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ImmunizationCubit>().refetchImmunizations(keyword: _keyword);
    });
  }

  void _onSelectedMonthYear(DateTime monthYear) {
    setState(() {
      _selectedMonthYear = monthYear;
    });

    context.read<ImmunizationCubit>().refetchImmunizations(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  void _onRemoveSelectedMonthYear() {
    setState(() {
      _selectedMonthYear = null;
    });

    context.read<ImmunizationCubit>().refetchImmunizations(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  @override
  void initState() {
    super.initState();
    _initMeasurementData();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    _searchDebounce?.cancel();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CadreImmunizationHeaderSection(
          keywordController: _keywordController,
          keyword: _keyword,
          onSearchImmunization: _onSearchImmunization,
          selectedMonthYear: _selectedMonthYear,
          onSelectedMonthYear: _onSelectedMonthYear,
          onRemoveSelectedMonthYear: _onRemoveSelectedMonthYear,
        ),
        CadreImmunizationListSection(
          keyword: _keyword,
          selectedMonthYear: _selectedMonthYear,
          onRefresh: _onRefresh,
          scrollController: _scrollController,
        ),
      ],
    );
  }
}
