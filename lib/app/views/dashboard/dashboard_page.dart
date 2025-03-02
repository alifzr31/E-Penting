import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
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
  @override
  void initState() {
    context.read<AuthCubit>().fetchProfile().then((value) {
      if (mounted) {
        context.read<DashboardCubit>().fetchPercentage();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const HomePage());
  }
}
