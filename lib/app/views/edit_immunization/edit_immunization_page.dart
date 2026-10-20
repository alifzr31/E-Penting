import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/survey/survey_cubit.dart';
import 'package:e_penting/app/views/edit_immunization/edit_immunization_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditImmunizationPage extends StatelessWidget {
  const new({required this.immunizationId, super.key});

  final int immunizationId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ImmunizationCubit>()),
        BlocProvider(create: (context) => sl<SurveyCubit>()),
      ],
      child: EditImmunizationView(immunizationId: immunizationId),
    );
  }
}
