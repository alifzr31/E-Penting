import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/parent/immunization/immunization_history_card.dart';
import 'package:e_penting/app/views/dashboard/components/parent/immunization/immunization_history_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentImmunizationHistorySection extends StatelessWidget {
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
                'Riwayat Imunisasi',
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
                  child: BlocBuilder<ImmunizationCubit, ImmunizationState>(
                    buildWhen: (previous, current) {
                      return previous.immunizationHistoryNikStatus !=
                          current.immunizationHistoryNikStatus;
                    },
                    builder: (context, state) {
                      switch (state.immunizationHistoryNikStatus) {
                        case .error:
                          return BaseHandleState(
                            handleType: .error,
                            errorMessageSize: 12,
                            iconButtonSize: 16,
                            labelButtonSize: 12,
                            errorMessage:
                                state.immunizationHistoryNikErrorMessage ?? '',
                            onRefetch: () {
                              final selectedChild = context
                                  .read<SelectedChildCubit>()
                                  .state;

                              context
                                  .read<ImmunizationCubit>()
                                  .refetchImmunizationHistoryNik(
                                    nik: selectedChild?.nik,
                                  );
                            },
                          );
                        case .success:
                          return state.immunizationHistoriesNik.isEmpty
                              ? BaseHandleState(
                                  handleType: .empty,
                                  errorMessageSize: 12,
                                  labelButtonSize: 12,
                                  iconButtonSize: 16,
                                  errorMessage:
                                      'Belum ada imunisasi yang dilakukan :{',
                                  onRefetch: () {
                                    final selectedChild = context
                                        .read<SelectedChildCubit>()
                                        .state;

                                    context
                                        .read<ImmunizationCubit>()
                                        .refetchImmunizationHistoryNik(
                                          nik: selectedChild?.nik,
                                        );
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: .zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.immunizationHistoriesNik.length,
                                  itemBuilder: (context, index) {
                                    final immunization =
                                        state.immunizationHistoriesNik[index];

                                    return ImmunizationHistoryCard(
                                      immunizationDate:
                                          immunization.tanggalImunisasi,
                                      vaccines:
                                          immunization.imunisasi ?? const [],
                                      dataLength:
                                          state.immunizationHistoriesNik.length,
                                      index: index,
                                    );
                                  },
                                );
                        default:
                          return const ImmunizationHistoryLoading();
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
