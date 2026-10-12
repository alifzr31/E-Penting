import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/edit_measurement/edit_measurement_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMeasurementPage extends StatelessWidget {
  const new({required this.measurementId, super.key});

  final int measurementId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ToddlerCubit>()),
        BlocProvider(create: (context) => sl<MeasurementCubit>()),
      ],
      child: EditMeasurementView(measurementId: measurementId),
    );
  }
}
