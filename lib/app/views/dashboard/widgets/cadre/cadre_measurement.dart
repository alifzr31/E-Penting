import 'dart:async' show Timer;

import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/measurement/cadre_measurement_header_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/measurement/cadre_measurement_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreMeasurement extends StatefulWidget {
  const new({super.key});

  @override
  State<CadreMeasurement> createState() => _CadreMeasurementState();
}

class _CadreMeasurementState extends State<CadreMeasurement> {
  final _keywordController = TextEditingController();
  String? _keyword;
  Timer? _searchDebounce;
  DateTime? _selectedMonthYear;
  final _scrollController = ScrollController();

  Future<void> _initMeasurementData() async {
    _scrollController.addListener(_onScroll);

    final measurementCubit = context.read<MeasurementCubit>();

    await measurementCubit.fetchMeasurements(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  void _onSearchMeasurement(String? keyword) {
    _keyword = keyword;
    if (_selectedMonthYear != null) {
      _selectedMonthYear = null;
    }
    setState(() {});

    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      context.read<MeasurementCubit>().refetchMeasurements(keyword: _keyword);
    });
  }

  void _onSelectedMonthYear(DateTime monthYear) {
    setState(() {
      _selectedMonthYear = monthYear;
    });

    context.read<MeasurementCubit>().refetchMeasurements(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  void _onRemoveSelectedMonthYear() {
    setState(() {
      _selectedMonthYear = null;
    });

    context.read<MeasurementCubit>().refetchMeasurements(
      month: _selectedMonthYear?.month,
      year: _selectedMonthYear?.year,
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final hasMore = context.read<MeasurementCubit>().state.hasMoreMeasurement;

    if (currentScroll == maxScroll && hasMore) {
      context.read<MeasurementCubit>().fetchMeasurements(
        month: _selectedMonthYear?.month,
        year: _selectedMonthYear?.year,
      );
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final measurementCubit = context.read<MeasurementCubit>();

      measurementCubit.refetchMeasurements(
        keyword: _keyword,
        month: _selectedMonthYear?.month,
        year: _selectedMonthYear?.year,
      );
    });
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
        CadreMeasurementHeaderSection(
          keywordController: _keywordController,
          keyword: _keyword,
          onSearchMeasurement: _onSearchMeasurement,
          selectedMonthYear: _selectedMonthYear,
          onSelectedMonthYear: _onSelectedMonthYear,
          onRemoveSelectedMonthYear: _onRemoveSelectedMonthYear,
        ),
        CadreMeasurementListSection(
          keyword: _keyword,
          selectedMonthYear: _selectedMonthYear,
          onRefresh: _onRefresh,
          scrollController: _scrollController,
        ),
      ],
    );
  }
}
