import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/immunization/immunization_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/immunization/immunization_card_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_loadscroll.dart';
import 'package:e_penting/app/widgets/base_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreImmunizationListSection extends StatelessWidget {
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
      child: BlocBuilder<ImmunizationCubit, ImmunizationState>(
        buildWhen: (previous, current) {
          return previous.immunizationStatus != current.immunizationStatus ||
              previous.immunizations != current.immunizations ||
              previous.hasMoreImmunization != current.hasMoreImmunization;
        },
        builder: (context, state) {
          switch (state.immunizationStatus) {
            case .error:
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const .all(16),
                  child: BaseHandleState(
                    handleType: .error,
                    lottieWidth: 180,
                    errorMessage: state.immunizationErrorMessage ?? '',
                    onRefetch: () {
                      context.read<ImmunizationCubit>().refetchImmunizations(
                        keyword: keyword,
                        month: selectedMonthYear?.month,
                        year: selectedMonthYear?.year,
                      );
                    },
                  ),
                ),
              );
            case .success:
              final immunizations = state.immunizations;
              final hasMore = state.hasMoreImmunization;

              return immunizations.isEmpty
                  ? SafeArea(
                      top: false,
                      child: Padding(
                        padding: const .all(16),
                        child: BaseHandleState(
                          handleType: .empty,
                          lottieWidth: 180,
                          errorMessage:
                              keyword != null && (keyword?.isNotEmpty ?? false)
                              ? 'Imunisasi dengan nama balita "$keyword" tidak ditemukan'
                              : selectedMonthYear != null
                              ? 'Imunisasi pada bulan "${selectedMonthYear?.monthYear()}" tidak ditemukan'
                              : 'Belum ada data imunisasi :(',
                          onRefetch: () {
                            context
                                .read<ImmunizationCubit>()
                                .refetchImmunizations(
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
                            ? immunizations.length + 1
                            : immunizations.length,
                        itemBuilder: (context, index) {
                          return SafeArea(
                            top: false,
                            bottom: hasMore
                                ? index == immunizations.length
                                      ? true
                                      : false
                                : index == immunizations.length - 1
                                ? true
                                : false,
                            child: index >= immunizations.length
                                ? const BaseLoadScroll()
                                : ImmunizationCard(
                                    toddlerName:
                                        immunizations[index].namaAnak ?? '',
                                    immunizationDay:
                                        immunizations[index].hari ?? '',
                                    immunizationDate:
                                        immunizations[index].tanggalImunisasi ??
                                        '',
                                    dataLength: immunizations.length,
                                    index: index,
                                    onTap: () async {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        RouteName.editImmunization,
                                        arguments:
                                            immunizations[index].idImunisasi,
                                      );

                                      if (!context.mounted || result == null) {
                                        return;
                                      }

                                      final isSuccess = result as bool;

                                      if (isSuccess) {
                                        context
                                            .read<ImmunizationCubit>()
                                            .refetchImmunizations(
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
              return const ImmunizationCardLoading();
          }
        },
      ),
    );
  }
}
