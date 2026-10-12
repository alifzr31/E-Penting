import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/parent/growth/measurement_graph.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeightMeasurementGraph extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, MeasurementState>(
      buildWhen: (previous, current) {
        return previous.heightMeasurementGraphNikStatus !=
            current.heightMeasurementGraphNikStatus;
      },
      builder: (context, state) {
        switch (state.heightMeasurementGraphNikStatus) {
          case .error:
            return BaseHandleState(
              handleType: .error,
              errorMessageSize: 12,
              iconButtonSize: 16,
              labelButtonSize: 12,
              errorMessage: state.heightMeasurementGraphNikErrorMessage ?? '',
              onRefetch: () {
                final selectedChild = context.read<SelectedChildCubit>().state;

                context
                    .read<MeasurementCubit>()
                    .refetchHeightMeasurementGraphNik(nik: selectedChild?.nik);
              },
            );
          case .success:
            final isEmpty =
                state.heightMeasurementGraphNik == null ||
                (state.heightMeasurementGraphNik?.labels?.isEmpty ?? false) ||
                (state.heightMeasurementGraphNik?.datas?.isEmpty ?? false);

            return isEmpty
                ? BaseHandleState(
                    handleType: .empty,
                    errorMessageSize: 12,
                    iconButtonSize: 16,
                    labelButtonSize: 12,
                    errorMessage:
                        state.heightMeasurementGraphNikErrorMessage ?? '',
                    onRefetch: () {
                      final selectedChild = context
                          .read<SelectedChildCubit>()
                          .state;

                      context
                          .read<MeasurementCubit>()
                          .refetchHeightMeasurementGraphNik(
                            nik: selectedChild?.nik,
                          );
                    },
                  )
                : MeasurementGraph(
                    intervalData: 20,
                    unitData: 'cm',
                    labels: state.heightMeasurementGraphNik?.labels ?? const [],
                    datas: state.heightMeasurementGraphNik?.datas ?? const [],
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
