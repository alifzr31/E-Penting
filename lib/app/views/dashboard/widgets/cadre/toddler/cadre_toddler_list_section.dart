import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/toddler/toddler_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/toddler/toddler_card_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_loadscroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreToddlerListSection extends StatelessWidget {
  const new({
    required this.scrollController,
    required this.keyword,
    required this.selectedRangeMonthAge,
    super.key,
  });

  final ScrollController scrollController;
  final String? keyword;
  final String? selectedRangeMonthAge;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ToddlerCubit, ToddlerState>(
        buildWhen: (previous, current) {
          return previous.toddlerStatus != current.toddlerStatus ||
              previous.toddlers != current.toddlers ||
              previous.hasMoreToddler != current.hasMoreToddler;
        },
        builder: (context, state) {
          switch (state.toddlerStatus) {
            case .error:
              return SafeArea(
                top: false,
                child: Padding(
                  padding: const .all(16),
                  child: BaseHandleState(
                    handleType: .error,
                    lottieWidth: 180,
                    errorMessage: state.toddlerErrorMessage ?? '',
                    onRefetch: () {
                      context.read<ToddlerCubit>().refetchToddlers(
                        keyword: keyword,
                        rangeMonthAge: selectedRangeMonthAge,
                      );
                    },
                  ),
                ),
              );
            case .success:
              return state.toddlers.isEmpty
                  ? SafeArea(
                      top: false,
                      child: Padding(
                        padding: const .all(16),
                        child: BaseHandleState(
                          handleType: .empty,
                          lottieWidth: 180,
                          errorMessage:
                              keyword != null && (keyword?.isNotEmpty ?? false)
                              ? 'Balita dengan nama "$keyword" tidak ditemukan'
                              : selectedRangeMonthAge != null &&
                                    selectedRangeMonthAge != 'all'
                              ? 'Balita dengan rentang usia $selectedRangeMonthAge bulan tidak ada'
                              : 'Belum ada data balita :(',
                          onRefetch: () {
                            context.read<ToddlerCubit>().refetchToddlers(
                              keyword: keyword,
                              rangeMonthAge: selectedRangeMonthAge,
                            );
                          },
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: keyword == null || (keyword?.isEmpty ?? false)
                          ? const .only(top: 4, left: 16, right: 16, bottom: 16)
                          : const .all(16),
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.hasMoreToddler
                          ? state.toddlers.length + 1
                          : state.toddlers.length,
                      itemBuilder: (context, index) {
                        return SafeArea(
                          top: false,
                          bottom: state.hasMoreToddler
                              ? index == state.toddlers.length
                                    ? true
                                    : false
                              : index == state.toddlers.length - 1
                              ? true
                              : false,
                          child: index >= state.toddlers.length
                              ? const BaseLoadScroll()
                              : ToddlerCard(
                                  toddlerGender:
                                      state.toddlers[index].jenisKelamin,
                                  toddlerName:
                                      state.toddlers[index].namaAnak ?? '',
                                  toddlerNumber:
                                      state.toddlers[index].anakKe ?? 0,
                                  toddlerMonthAge:
                                      state.toddlers[index].bulanUsia ?? 0,
                                  toddlerHeight:
                                      state.toddlers[index].tinggi ?? 0.0,
                                  toddlerWeight:
                                      state.toddlers[index].beratLahir ?? 0.0,
                                  dataLength: state.toddlers.length,
                                  index: index,
                                  onTap: () async {
                                    final result = await Navigator.pushNamed(
                                      context,
                                      RouteName.editToddler,
                                      arguments: state.toddlers[index].id,
                                    );

                                    if (!context.mounted || result == null) {
                                      return;
                                    }

                                    final isSuccess = result as bool;

                                    if (isSuccess) {
                                      context
                                          .read<ToddlerCubit>()
                                          .refetchToddlers(
                                            keyword: keyword,
                                            rangeMonthAge:
                                                selectedRangeMonthAge,
                                          );
                                    }
                                  },
                                ),
                        );
                      },
                    );
            default:
              return const ToddlerCardLoading();
          }
        },
      ),
    );
  }
}
