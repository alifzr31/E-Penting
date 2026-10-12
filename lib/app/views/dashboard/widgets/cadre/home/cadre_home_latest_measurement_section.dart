import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_measurement_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_measurement_card_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreHomeLatestMeasurementSection extends StatelessWidget {
  const new({this.onSeeAllMeasurement, super.key});

  final VoidCallback? onSeeAllMeasurement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: SizedBox(
        width: .infinity,
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
                BaseTextButton(
                  text: 'Lihat Semua',
                  onPressed: onSeeAllMeasurement,
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocBuilder<MeasurementCubit, MeasurementState>(
              buildWhen: (previous, current) {
                return previous.latestMeasurementsStatus !=
                    current.latestMeasurementsStatus;
              },
              builder: (context, state) {
                switch (state.latestMeasurementsStatus) {
                  case .error:
                    return BaseHandleState(
                      handleType: .error,
                      errorMessage: state.latestMeasurementsError ?? '',
                      lottieWidth: 160,
                      onRefetch: () {
                        context
                            .read<MeasurementCubit>()
                            .refetchLatestMeasurements();
                      },
                    );
                  case .success:
                    return state.latestMeasurements.isEmpty
                        ? BaseHandleState(
                            handleType: .empty,
                            lottieWidth: 160,
                            errorMessage: 'Belum ada data pengukuran :(',
                            onRefetch: () {
                              context
                                  .read<MeasurementCubit>()
                                  .refetchLatestMeasurements();
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: .zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.latestMeasurements.length,
                            itemBuilder: (context, index) {
                              final measurement =
                                  state.latestMeasurements[index];

                              return LatestMeasurementCard(
                                toddlerName: measurement.namaAnak ?? ' ',
                                measurementDay: measurement.hari ?? '',
                                measurementDate:
                                    measurement.tanggalPenimbangan ?? '',
                                stuntingStatus: measurement.stanting ?? '',
                                dataLength: state.latestMeasurements.length,
                                index: index,
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    RouteName.editMeasurement,
                                    arguments: measurement.idPengukuran,
                                  );

                                  if (!context.mounted || result == null) {
                                    return;
                                  }

                                  final isSuccess = result as bool;

                                  if (isSuccess) {
                                    context
                                        .read<MeasurementCubit>()
                                        .refetchLatestMeasurements();
                                  }
                                },
                              );
                            },
                          );
                  default:
                    return const LatestMeasurementCardLoading();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
