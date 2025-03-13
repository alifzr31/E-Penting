import 'dart:async';

import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/views/dashboard/widgets/balita/balita_page.dart';
import 'package:epenting/app/views/dashboard/widgets/dashboard_bottomnav.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_page.dart';
import 'package:epenting/app/views/dashboard/widgets/imunisasi/imunisasi_page.dart';
import 'package:epenting/app/views/dashboard/widgets/pengukuran/pengukuran_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentPage = 0;

  DateTime? _selectedPengukuranDateFilter;
  final _pengukuranScrollController = ScrollController();
  Timer? _pengukuranDebounce;
  final _searchPengukuranController = TextEditingController();
  String? _searchPengukuran;

  DateTime? _selectedImunisasiDateFilter;
  final _imunisasiScrollController = ScrollController();
  Timer? _imunisasiDebounce;
  final _searchImunisasiController = TextEditingController();
  String? _searchImunisasi;

  final _balitaFilters = [
    'all',
    '0-6',
    '7-12',
    '13-24',
    '25-36',
    '37-48',
    '49-60',
  ];
  // String selectedFilter = 'all';
  final _balitaScrollController = ScrollController();
  Timer? _balitaDebounce;
  final _searchBalitaController = TextEditingController();
  String? _searchBalita;

  void _onScrollPengukuran() {
    if (_pengukuranScrollController.hasClients) {
      final currentScroll = _pengukuranScrollController.position.pixels;
      final maxScroll = _pengukuranScrollController.position.maxScrollExtent;

      if (currentScroll == maxScroll &&
          context.read<PengukuranCubit>().state.hasMorePengukuran) {
        context.read<PengukuranCubit>().fetchAllPengukuran(
          month: _selectedPengukuranDateFilter?.month,
          year: _selectedPengukuranDateFilter?.year,
        );
      }
    }
  }

  Future<void> _onPressedPengukuranDateFilter(BuildContext context) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selectedPengukuranDateFilter ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      locale: const Locale('id', 'ID'),
    );

    if (selected != null) {
      setState(() {
        _searchPengukuran = null;
        _selectedPengukuranDateFilter = selected;
      });
      _searchPengukuranController.clear();

      if (context.mounted) {
        context.read<PengukuranCubit>().refetchAllPengukuran(
          month: _selectedPengukuranDateFilter?.month,
          year: _selectedPengukuranDateFilter?.year,
        );
      }
    }
  }

  Future<void> _onRefreshPengukuran() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _selectedPengukuranDateFilter = null;
        _searchPengukuran = null;
      });
      _searchPengukuranController.clear();

      if (mounted) {
        context.read<PengukuranCubit>().refetchAllPengukuran();
      }
    });
  }

  void _onSearchPengukuran(String? value) {
    setState(() {
      if (_selectedPengukuranDateFilter != null) {
        _selectedPengukuranDateFilter = null;
      }
      _searchPengukuran = value;
    });

    if (_pengukuranDebounce?.isActive ?? false) _pengukuranDebounce?.cancel();
    _pengukuranDebounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchPengukuran?.isEmpty ?? false) {
        context.read<PengukuranCubit>().refetchAllPengukuran();
      } else {
        context.read<PengukuranCubit>().refetchAllPengukuran(
          isSearch: true,
          search: _searchPengukuran,
        );
      }
    });
  }

  void _onPressedShowAllMonthPengukuran() {
    setState(() {
      _selectedPengukuranDateFilter = null;
    });

    context.read<PengukuranCubit>().refetchAllPengukuran();
  }

  void _onScrollImunisasi() {
    if (_imunisasiScrollController.hasClients) {
      final currentScroll = _imunisasiScrollController.position.pixels;
      final maxScroll = _imunisasiScrollController.position.maxScrollExtent;

      if (currentScroll == maxScroll &&
          context.read<ImunisasiCubit>().state.hasMoreImunisasi) {
        context.read<ImunisasiCubit>().fetchAllImunisasi(
          month: _selectedImunisasiDateFilter?.month,
          year: _selectedImunisasiDateFilter?.year,
        );
      }
    }
  }

  Future<void> _onPressedImunisasiDateFilter(BuildContext context) async {
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selectedImunisasiDateFilter ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
      locale: const Locale('id', 'ID'),
    );

    if (selected != null) {
      setState(() {
        _searchImunisasi = null;
        _selectedImunisasiDateFilter = selected;
      });
      _searchImunisasiController.clear();

      if (context.mounted) {
        context.read<ImunisasiCubit>().refetchAllImunisasi(
          month: _selectedImunisasiDateFilter?.month,
          year: _selectedImunisasiDateFilter?.year,
        );
      }
    }
  }

  Future<void> _onRefreshImunisasi() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _selectedImunisasiDateFilter = null;
        _searchImunisasi = null;
      });
      _searchImunisasiController.clear();

      if (mounted) {
        context.read<ImunisasiCubit>().refetchAllImunisasi();
      }
    });
  }

  void _onSearchImunisasi(String? value) {
    setState(() {
      if (_selectedImunisasiDateFilter != null) {
        _selectedImunisasiDateFilter = null;
      }
      _searchImunisasi = value;
    });

    if (_imunisasiDebounce?.isActive ?? false) _imunisasiDebounce?.cancel();
    _imunisasiDebounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchImunisasi?.isEmpty ?? false) {
        context.read<ImunisasiCubit>().refetchAllImunisasi();
      } else {
        context.read<ImunisasiCubit>().refetchAllImunisasi(
          isSearch: true,
          search: _searchImunisasi,
        );
      }
    });
  }

  void _onPressedShowAllMonthImunisasi() {
    setState(() {
      _selectedImunisasiDateFilter = null;
    });

    context.read<ImunisasiCubit>().refetchAllImunisasi();
  }

  void _onScrollBalita() {
    if (_balitaScrollController.hasClients) {
      final currentScroll = _balitaScrollController.position.pixels;
      final maxScroll = _balitaScrollController.position.maxScrollExtent;

      if (currentScroll == maxScroll &&
          context.read<BalitaCubit>().state.hasMoreBalita) {
        context.read<BalitaCubit>().fetchAllBalita();
      }
    }
  }

  Future<void> _onRefreshBalita() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _searchBalita = null;
      });
      _searchBalitaController.clear();

      if (mounted) {
        context.read<BalitaCubit>().refetchAllBalita();
      }
    });
  }

  void _onSearchBalita(String? value) {
    setState(() {
      _searchBalita = value;
    });

    if (_balitaDebounce?.isActive ?? false) _balitaDebounce?.cancel();
    _balitaDebounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchBalita?.isEmpty ?? false) {
        context.read<BalitaCubit>().refetchAllBalita();
      } else {
        context.read<BalitaCubit>().refetchAllBalita(
          isSearch: true,
          search: _searchBalita,
          filter: 'all',
        );
      }
    });
  }

  @override
  void initState() {
    context.read<AuthCubit>().fetchProfile().then((value) {
      if (mounted) {
        context.read<DashboardCubit>().loadData();
        context.read<PengukuranCubit>().fetchAllPengukuran().then((value) {
          _pengukuranScrollController.addListener(_onScrollPengukuran);
        });
        context.read<ImunisasiCubit>().fetchAllImunisasi().then((value) {
          _imunisasiScrollController.addListener(_onScrollImunisasi);
        });
        context.read<BalitaCubit>().fetchAllBalita().then((value) {
          _balitaScrollController.addListener(_onScrollBalita);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pengukuranScrollController
      ..removeListener(_onScrollPengukuran)
      ..dispose();
    _pengukuranDebounce?.cancel();
    _searchPengukuranController.dispose();
    _imunisasiScrollController
      ..removeListener(_onScrollImunisasi)
      ..dispose();
    _imunisasiDebounce?.cancel();
    _searchImunisasiController.dispose();
    _balitaScrollController
      ..removeListener(_onScrollBalita)
      ..dispose();
    _balitaDebounce?.cancel();
    _searchBalitaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_currentPage == 0) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else {
            setState(() {
              _currentPage = 0;
            });
          }
        }
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: _currentPage == 0 ? null : false,
        bottomNavigationBar: DashboardBottomNav(
          currentPage: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        body: IndexedStack(
          index: _currentPage,
          children: [
            HomePage(
              seeAllPengukuran: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              seeAllImunisasi: () {
                setState(() {
                  _currentPage = 2;
                });
              },
              seeAllBalita: () {
                setState(() {
                  _currentPage = 3;
                });
              },
            ),
            PengukuranPage(
              selectedPengukuranDateFilter: _selectedPengukuranDateFilter,
              onPressedPengukuranDateFilter: () {
                _onPressedPengukuranDateFilter(context);
              },
              pengukuranScrollController: _pengukuranScrollController,
              onRefreshPengukuran: _onRefreshPengukuran,
              searchPengukuranController: _searchPengukuranController,
              onSearchPengukuran: _onSearchPengukuran,
              onPressedShowAllMonthPengukuran: _onPressedShowAllMonthPengukuran,
            ),
            ImunisasiPage(
              selectedImunisasiDateFilter: _selectedImunisasiDateFilter,
              onPressedImunisasiDateFilter: () {
                _onPressedImunisasiDateFilter(context);
              },
              imunisasiScrollController: _imunisasiScrollController,
              onRefreshImunisasi: _onRefreshImunisasi,
              searchImunisasiController: _searchImunisasiController,
              onSearchImunisasi: _onSearchImunisasi,
              onPressedShowAllMonthImunisasi: _onPressedShowAllMonthImunisasi,
            ),
            BalitaPage(
              balitaFilters: _balitaFilters,
              balitaScrollController: _balitaScrollController,
              onRefreshBalita: _onRefreshBalita,
              searchBalitaController: _searchBalitaController,
              onSearchBalita: _onSearchBalita,
            ),
          ],
        ),
      ),
    );
  }
}
