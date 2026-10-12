import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/models/vaccine.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/parent/immunization/administered_immunization_loading.dart';
import 'package:e_penting/app/views/dashboard/components/parent/immunization/administered_immunization_vaccine_card.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentAdministeredImmunizationSection extends StatelessWidget {
  const new({required this.vaccines, super.key});

  final List<Vaccine> vaccines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        children: [
          const Align(
            alignment: .centerLeft,
            child: Text(
              'Imunisasi yang Sudah Dilakukan',
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
                        final lastImmunization =
                            state.immunizationHistoriesNik.isEmpty
                            ? null
                            : state.immunizationHistoriesNik.first;
                        final administeredVaccineImmunization =
                            lastImmunization?.imunisasi?.map((e) {
                              return e
                                  .replaceAll(RegExp(r'[\s-]'), '')
                                  .toLowerCase();
                            }).toList() ??
                            const [];

                        return Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              padding: .zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                    childAspectRatio: 6,
                                  ),
                              itemCount: vaccines.length,
                              itemBuilder: (context, index) {
                                final vaccine = vaccines[index];
                                final isMatched =
                                    administeredVaccineImmunization.contains(
                                      vaccine.id,
                                    );

                                return AdministeredImmunizationVaccineCard(
                                  vaccineName: vaccine.label,
                                  isMatched: isMatched,
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Terakhir Diperbarui :',
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Align(
                                    alignment: .centerRight,
                                    child: Text(
                                      lastImmunization?.tanggalImunisasi == null
                                          ? '-'
                                          : lastImmunization!.tanggalImunisasi!
                                                .dayMonthYear(),
                                      textAlign: .right,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: .w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      default:
                        return AdministeredImmunizationLoading(
                          dataLength: vaccines.length,
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
