import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/create_immunization/create_immunization_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateImmunizationPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ToddlerCubit>()),
        BlocProvider(create: (context) => sl<ImmunizationCubit>()),
      ],
      child: const CreateImmunizationView(),
    );
  }
}
