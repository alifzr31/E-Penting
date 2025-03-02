import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) {
            context.read<AuthCubit>().refetchProfile();
            context.read<DashboardCubit>().refetchPercentage();
          }
        });
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [const HomeHeader()],
      ),
    );
  }
}
