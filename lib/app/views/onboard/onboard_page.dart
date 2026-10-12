import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/onboard/onboard_cubit.dart';
import 'package:e_penting/app/views/onboard/onboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OnboardCubit>(),
      child: const OnboardView(),
    );
  }
}
