import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/nutrition/nutrition_cubit.dart';
import 'package:e_penting/app/views/nutrition/nutrition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NutritionCubit>(),
      child: const NutritionView(),
    );
  }
}
