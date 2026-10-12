import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/parent/home/last_measurement_card.dart';
import 'package:e_penting/app/views/dashboard/components/parent/home/last_measurement_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ParentLastMeasurementSection extends StatelessWidget {
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
                  'Pengukuran Terakhir',
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
                        return Column(
                          children: [
                            Row(
                              children: [
                                LastMeasurementCard(
                                  bgColor: Colors.green.shade100,
                                  icon: RemixIcon.dashboard3Line,
                                  iconColor: Colors.green.shade600,
                                  label: 'Berat\nBadan',
                                  value:
                                      '${state.toddlerLatestNik?.pengukuran?.berat} kg',
                                ),
                                const SizedBox(width: 10),
                                LastMeasurementCard(
                                  bgColor: Colors.blue.shade100,
                                  icon: RemixIcon.expandVerticalLine,
                                  iconColor: Colors.blue.shade600,
                                  label: 'Tinggi\nBadan',
                                  value:
                                      '${state.toddlerLatestNik?.pengukuran?.tinggi} cm',
                                ),
                                const SizedBox(width: 10),
                                LastMeasurementCard(
                                  bgColor: Colors.orange.shade100,
                                  icon: RemixIcon.expandDiagonalLine,
                                  iconColor: Colors.orange.shade600,
                                  label: 'Lingkar\nKepala',
                                  value:
                                      state
                                              .toddlerLatestNik
                                              ?.pengukuran
                                              ?.lingkarKepala ==
                                          null
                                      ? '-'
                                      : '${state.toddlerLatestNik?.pengukuran?.lingkarKepala} cm',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  'Pengukuran Terakhir :',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: .centerRight,
                                    child: Text(
                                      state
                                              .toddlerLatestNik
                                              ?.pengukuran
                                              ?.tanggalUkur
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
                        return const LastMeasurementLoading();
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
