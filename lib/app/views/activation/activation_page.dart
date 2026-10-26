import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/activation/activation_cubit.dart';
import 'package:e_penting/app/views/activation/activation_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivationPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ActivationCubit>(),
      child: const ActivationView(),
    );
  }
}
