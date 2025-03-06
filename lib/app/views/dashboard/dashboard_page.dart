import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/views/dashboard/widgets/dashboard_bottomnav.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_page.dart';
import 'package:epenting/app/views/dashboard/widgets/pengukuran/pengukuran_page.dart';
import 'package:flutter/material.dart';
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
        _selectedPengukuranDateFilter = selected;
      });

      if (context.mounted) {
        context.read<PengukuranCubit>().refetchAllPengukuran(
          month: _selectedPengukuranDateFilter?.month,
          year: _selectedPengukuranDateFilter?.year,
        );
      }
    }
  }

  Future<void> onRefreshPengukuran() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _selectedPengukuranDateFilter = null;
      });

      if (mounted) {
        context.read<PengukuranCubit>().refetchAllPengukuran();
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
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pengukuranScrollController
      ..removeListener(_onScrollPengukuran)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            onPressedPengukuranDateFilter: () async {
              _onPressedPengukuranDateFilter(context);
            },
            pengukuranScrollController: _pengukuranScrollController,
            onRefreshPengukuran: onRefreshPengukuran,
          ),
          const Center(child: Text('Imunisasi')),
          const Center(child: Text('Balita')),
        ],
      ),
    );
  }
}
