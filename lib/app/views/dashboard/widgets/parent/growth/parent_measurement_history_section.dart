import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/parent/growth/measurement_history_card.dart';
import 'package:e_penting/app/views/dashboard/components/parent/growth/measurement_history_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentMeasurementHistorySection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const .only(left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            const Align(
              alignment: .centerLeft,
              child: Text(
                'Riwayat Pengukuran',
                style: TextStyle(fontSize: 16, fontWeight: .w600),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: .infinity,
              child: Material(
                elevation: 1,
                color: Colors.white,
                clipBehavior: .antiAlias,
                borderRadius: .circular(10),
                child: Padding(
                  padding: const .all(16),
                  child: BlocBuilder<MeasurementCubit, MeasurementState>(
                    buildWhen: (previous, current) {
                      return previous.measurementHistoryNikStatus !=
                          current.measurementHistoryNikStatus;
                    },
                    builder: (context, state) {
                      switch (state.measurementHistoryNikStatus) {
                        case .error:
                          return BaseHandleState(
                            handleType: .error,
                            errorMessageSize: 12,
                            iconButtonSize: 16,
                            labelButtonSize: 12,
                            errorMessage:
                                state.measurementHistoryNikErrorMessage ?? '',
                            onRefetch: () {
                              final selectedChild = context
                                  .read<SelectedChildCubit>()
                                  .state;

                              context
                                  .read<MeasurementCubit>()
                                  .refetchMeasurementHistoryNik(
                                    nik: selectedChild?.nik,
                                  );
                            },
                          );
                        case .success:
                          return state.measurementHistoryNik.isEmpty
                              ? BaseHandleState(
                                  handleType: .empty,
                                  errorMessageSize: 12,
                                  labelButtonSize: 12,
                                  iconButtonSize: 16,
                                  errorMessage:
                                      'Belum ada pengukuran yang dilakukan :{',
                                  onRefetch: () {
                                    final selectedChild = context
                                        .read<SelectedChildCubit>()
                                        .state;

                                    context
                                        .read<MeasurementCubit>()
                                        .refetchMeasurementHistoryNik(
                                          nik: selectedChild?.nik,
                                        );
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: .zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.measurementHistoryNik.length,
                                  itemBuilder: (context, index) {
                                    final measurement =
                                        state.measurementHistoryNik[index];

                                    return MeasurementHistoryCard(
                                      measurementDate: measurement.tanggalUkur,
                                      weight: measurement.berat ?? 0,
                                      height: measurement.tinggi ?? 0,
                                      dataLength:
                                          state.measurementHistoryNik.length,
                                      index: index,
                                    );
                                  },
                                );
                        default:
                          return const MeasurementHistoryLoading();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
