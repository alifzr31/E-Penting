import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/measurement/measurement_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/measurement/measurement_card_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_loadscroll.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreMeasurementListSection extends StatelessWidget {
  const new({
    required this.keyword,
    required this.selectedMonthYear,
    required this.onRefresh,
    required this.scrollController,
    super.key,
  });

  final String? keyword;
  final DateTime? selectedMonthYear;
  final Future<void> Function() onRefresh;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MeasurementCubit, MeasurementState>(
        buildWhen: (previous, current) {
          return previous.measurementStatus != current.measurementStatus ||
              previous.measurements != current.measurements ||
              previous.hasMoreMeasurement != current.hasMoreMeasurement;
        },
        builder: (context, state) {
          switch (state.measurementStatus) {
            case .error:
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const .all(16),
                  child: BaseHandleState(
                    handleType: .error,
                    lottieWidth: 180,
                    errorMessage: state.measurementErrorMessage ?? '',
                    onRefetch: () {
                      context.read<MeasurementCubit>().refetchMeasurements(
                        keyword: keyword,
                        month: selectedMonthYear?.month,
                        year: selectedMonthYear?.year,
                      );
                    },
                  ),
                ),
              );
            case .success:
              final measurements = state.measurements;
              final hasMore = state.hasMoreMeasurement;

              return measurements.isEmpty
                  ? SafeArea(
                      top: false,
                      child: Padding(
                        padding: const .all(16),
                        child: BaseHandleState(
                          handleType: .empty,
                          lottieWidth: 180,
                          errorMessage:
                              keyword != null && (keyword?.isNotEmpty ?? false)
                              ? 'Pengukuran dengan nama balita "$keyword" tidak ditemukan'
                              : selectedMonthYear != null
                              ? 'Pengukuran pada bulan "${selectedMonthYear?.monthYear()}" tidak ditemukan'
                              : 'Belum ada data pengukuran :(',
                          onRefetch: () {
                            context
                                .read<MeasurementCubit>()
                                .refetchMeasurements(
                                  keyword: keyword,
                                  month: selectedMonthYear?.month,
                                  year: selectedMonthYear?.year,
                                );
                          },
                        ),
                      ),
                    )
                  : BaseRefreshIndicator(
                      onRefresh: onRefresh,
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const .all(16),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: hasMore
                            ? measurements.length + 1
                            : measurements.length,
                        itemBuilder: (context, index) {
                          return SafeArea(
                            top: false,
                            bottom: hasMore
                                ? index == measurements.length
                                      ? true
                                      : false
                                : index == measurements.length - 1
                                ? true
                                : false,
                            child: index >= measurements.length
                                ? const BaseLoadScroll()
                                : MeasurementCard(
                                    toddlerName:
                                        measurements[index].namaAnak ?? '',
                                    measurementDay:
                                        measurements[index].hari ?? '',
                                    measurementDate:
                                        measurements[index]
                                            .tanggalPenimbangan ??
                                        '',
                                    stuntingStatus:
                                        measurements[index].stanting ?? '',
                                    dataLength: measurements.length,
                                    index: index,
                                    onTap: () async {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        RouteName.editMeasurement,
                                        arguments:
                                            measurements[index].idPengukuran,
                                      );

                                      if (!context.mounted || result == null) {
                                        return;
                                      }

                                      final isSuccess = result as bool;

                                      if (isSuccess) {
                                        context
                                            .read<MeasurementCubit>()
                                            .refetchMeasurements(
                                              keyword: keyword,
                                              month: selectedMonthYear?.month,
                                              year: selectedMonthYear?.year,
                                            );
                                      }
                                    },
                                  ),
                          );
                        },
                      ),
                    );
            default:
              return const MeasurementCardLoading();
          }
        },
      ),
    );
  }
}
