import 'dart:async' show Timer;

import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/toddler/cadre_toddler_filter_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/toddler/cadre_toddler_header_section.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/toddler/cadre_toddler_list_section.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreToddler extends StatefulWidget {
  const new({super.key});

  @override
  State<CadreToddler> createState() => _CadreToddlerState();
}

class _CadreToddlerState extends State<CadreToddler> {
  final _scrollController = ScrollController();
  final _keywordController = TextEditingController();
  String? _keyword;
  Timer? _searchDebounce;
  final List<String> _rangeMonthAge = const [
    'all',
    '0-6',
    '7-12',
    '13-24',
    '25-36',
    '37-48',
  ];
  String? _selectedRangeMonthAge;

  Future<void> _initToddlerData() async {
    _selectedRangeMonthAge = _rangeMonthAge.first;
    _scrollController.addListener(_onScroll);
    setState(() {});

    final toddlerCubit = context.read<ToddlerCubit>();

    await toddlerCubit.fetchToddlers(rangeMonthAge: _selectedRangeMonthAge);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final hasMore = context.read<ToddlerCubit>().state.hasMoreToddler;

    if (currentScroll == maxScroll && hasMore) {
      context.read<ToddlerCubit>().fetchToddlers(
        rangeMonthAge: _selectedRangeMonthAge,
      );
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      final toddlerCubit = context.read<ToddlerCubit>();

      toddlerCubit.refetchToddlers(
        keyword: _keyword,
        rangeMonthAge: _selectedRangeMonthAge,
      );
    });
  }

  void _onSearchToddler(String? keyword) {
    _keyword = keyword;
    if (_selectedRangeMonthAge != null &&
        _selectedRangeMonthAge != _rangeMonthAge.first) {
      _selectedRangeMonthAge = _rangeMonthAge.first;
    }
    setState(() {});

    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ToddlerCubit>().refetchToddlers(keyword: _keyword);
    });
  }

  void _onSelectedRangeMonthDate(String rangeMonthAge) {
    setState(() {
      _selectedRangeMonthAge = rangeMonthAge;
    });

    context.read<ToddlerCubit>().refetchToddlers(
      rangeMonthAge: _selectedRangeMonthAge,
    );
  }

  @override
  void initState() {
    super.initState();
    _initToddlerData();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _keywordController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CadreToddlerHeaderSection(
          keyword: _keyword,
          keywordController: _keywordController,
          onSearchToddler: _onSearchToddler,
          selectedRangeMonthAge: _selectedRangeMonthAge,
        ),
        Expanded(
          child: BaseRefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
              children: [
                if (_keyword == null || (_keyword?.isEmpty ?? false)) ...[
                  CadreToddlerFilterSection(
                    rangeMonthAge: _rangeMonthAge,
                    selectedRangeMonthAge: _selectedRangeMonthAge,
                    onSelectedRangeMonthAge: _onSelectedRangeMonthDate,
                  ),
                ],
                CadreToddlerListSection(
                  scrollController: _scrollController,
                  keyword: _keyword,
                  selectedRangeMonthAge: _selectedRangeMonthAge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
