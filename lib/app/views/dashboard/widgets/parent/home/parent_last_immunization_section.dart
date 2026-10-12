import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/parent/home/last_immunization_loading.dart';
import 'package:e_penting/app/views/dashboard/components/parent/home/last_immunization_vaccine_card.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentLastImmunizationSection extends StatelessWidget {
  const new({this.onSeeHistory, super.key});

  final VoidCallback? onSeeHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Imunisasi Terakhir',
                  style: TextStyle(fontSize: 16, fontWeight: .w600),
                ),
              ),
              const SizedBox(width: 10),
              BaseTextButton(text: 'Lihat Riwayat', onPressed: onSeeHistory),
            ],
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
                child: BlocBuilder<ToddlerCubit, ToddlerState>(
                  buildWhen: (previous, current) {
                    return previous.toddlerLatestNikStatus !=
                        current.toddlerLatestNikStatus;
                  },
                  builder: (context, state) {
                    switch (state.toddlerLatestNikStatus) {
                      case .error:
                        return BaseHandleState(
                          handleType: .error,
                          errorMessageSize: 12,
                          labelButtonSize: 12,
                          iconButtonSize: 16,
                          errorMessage:
                              state.toddlerLatestNikErrorMessage ?? '',
                          onRefetch: () {
                            final selectedChild = context
                                .read<SelectedChildCubit>()
                                .state;

                            context
                                .read<ToddlerCubit>()
                                .refetchToodlerLatestNik(
                                  nik: selectedChild?.nik,
                                );
                          },
                        );
                      case .success:
                        final vaccineNames =
                            state.toddlerLatestNik?.imunisasi?.list ?? [];

                        return vaccineNames.isEmpty
                            ? BaseHandleState(
                                handleType: .empty,
                                errorMessageSize: 12,
                                labelButtonSize: 12,
                                iconButtonSize: 16,
                                errorMessage:
                                    'Belum ada imunisasi yang dilakukan :(',
                                onRefetch: () {
                                  final selectedChild = context
                                      .read<SelectedChildCubit>()
                                      .state;

                                  context
                                      .read<ToddlerCubit>()
                                      .refetchToodlerLatestNik(
                                        nik: selectedChild?.nik,
                                      );
                                },
                              )
                            : Column(
                                children: [
                                  GridView(
                                    shrinkWrap: true,
                                    padding: .zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 6,
                                          childAspectRatio: 6,
                                        ),
                                    children: List.generate(
                                      vaccineNames.length,
                                      (index) {
                                        final vaccineName = vaccineNames[index];

                                        return LastImmunizationVaccineCard(
                                          vaccineName: vaccineName,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Text(
                                        'Imunisasi Terakhir :',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: .centerRight,
                                          child: Text(
                                            state
                                                    .toddlerLatestNik
                                                    ?.imunisasi
                                                    ?.tanggalImunisasi
                                                    ?.dayMonthYear() ??
                                                '',
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
                        return const LastImmunizationLoading();
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
