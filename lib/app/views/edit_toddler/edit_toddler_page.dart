import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/edit_toddler/edit_toddler_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditToddlerPage extends StatelessWidget {
  const new({required this.toddlerId, super.key});

  final int toddlerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ToddlerCubit>(),
      child: EditToddlerView(toddlerId: toddlerId),
    );
  }
}
