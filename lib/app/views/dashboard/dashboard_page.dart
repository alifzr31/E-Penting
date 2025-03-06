import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/views/dashboard/widgets/dashboard_bottomnav.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentPage = 0;

  @override
  void initState() {
    context.read<AuthCubit>().fetchProfile().then((value) {
      if (mounted) {
        context.read<DashboardCubit>().loadData();
      }
    });
    super.initState();
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
          const Center(child: Text('Pengukuran')),
          const Center(child: Text('Imunisasi')),
          const Center(child: Text('Balita')),
        ],
      ),
    );
  }
}
