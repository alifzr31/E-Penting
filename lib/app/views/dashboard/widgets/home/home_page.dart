import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_balita.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_header.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_imunisasi.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_pengukuran.dart';
import 'package:epenting/app/widgets/base_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    this.seeAllPengukuran,
    this.seeAllImunisasi,
    this.seeAllBalita,
    super.key,
  });

  final void Function()? seeAllPengukuran;
  final void Function()? seeAllImunisasi;
  final void Function()? seeAllBalita;

  @override
  Widget build(BuildContext context) {
    return BaseRefresh(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) {
            context.read<AuthCubit>().refetchProfile();
            context.read<DashboardCubit>().refetchPercentage();
            context.read<DashboardCubit>().refetchLatestBalita();
            context.read<DashboardCubit>().refetchLatestPengukuran();
            context.read<DashboardCubit>().refetchLatestImunisasi();
          }
        });
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const HomeHeader(),
          SizedBox(height: 10.h),
          HomeBalita(seeAllBalita: seeAllBalita),
          SizedBox(height: 10.h),
          HomePengukuran(seeAllPengukuran: seeAllPengukuran),
          SizedBox(height: 10.h),
          HomeImunisasi(seeAllImunisasi: seeAllImunisasi),
        ],
      ),
    );
  }
}
