import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/dashboard/parent_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ToddlerCubit>()),
        BlocProvider(create: (context) => sl<ImmunizationCubit>()),
        BlocProvider(create: (context) => sl<MeasurementCubit>()),
        BlocProvider(create: (context) => sl<SelectedChildCubit>()),
      ],
      child: const ParentView(),
    );
  }
}
