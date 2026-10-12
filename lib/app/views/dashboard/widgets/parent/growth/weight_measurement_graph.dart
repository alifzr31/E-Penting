import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/parent/growth/measurement_graph.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightMeasurementGraph extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, MeasurementState>(
      buildWhen: (previous, current) {
        return previous.weightMeasurementGraphNikStatus !=
            current.weightMeasurementGraphNikStatus;
      },
      builder: (context, state) {
        switch (state.weightMeasurementGraphNikStatus) {
          case .error:
            return BaseHandleState(
              handleType: .error,
              errorMessageSize: 12,
              iconButtonSize: 16,
              labelButtonSize: 12,
              errorMessage:
                  state.weightMeasurementGraphNikErrorMessage ?? 'dnjaskn',
              onRefetch: () {
                final selectedChild = context.read<SelectedChildCubit>().state;

                context
                    .read<MeasurementCubit>()
                    .refetchWeightMeasurementGraphNik(nik: selectedChild?.nik);
              },
            );
          case .success:
            final isEmpty =
                state.weightMeasurementGraphNik == null ||
                (state.weightMeasurementGraphNik?.labels?.isEmpty ?? false) ||
                (state.weightMeasurementGraphNik?.datas?.isEmpty ?? false);

            return isEmpty
                ? BaseHandleState(
                    handleType: .empty,
                    errorMessageSize: 12,
                    iconButtonSize: 16,
                    labelButtonSize: 12,
                    errorMessage:
                        state.weightMeasurementGraphNikErrorMessage ?? '',
                    onRefetch: () {
                      final selectedChild = context
                          .read<SelectedChildCubit>()
                          .state;

                      context
                          .read<MeasurementCubit>()
                          .refetchWeightMeasurementGraphNik(
                            nik: selectedChild?.nik,
                          );
                    },
                  )
                : MeasurementGraph(
                    intervalData: 5,
                    unitData: 'kg',
                    labels: state.weightMeasurementGraphNik?.labels ?? const [],
                    datas: state.weightMeasurementGraphNik?.datas ?? const [],
                  );
          default:
            return BaseSkeletonizer(
              child: Center(
                child: Container(
                  foregroundDecoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
