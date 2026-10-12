import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/stat/stat_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/dashboard/cadre_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadrePage extends StatelessWidget {
  const CadrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DashboardCubit>()..startTimer()),
        BlocProvider(create: (context) => sl<StatCubit>()),
        BlocProvider(create: (context) => sl<MeasurementCubit>()),
        BlocProvider(create: (context) => sl<ImmunizationCubit>()),
        BlocProvider(create: (context) => sl<ToddlerCubit>()),
      ],
      child: const CadreView(),
    );
  }
}
