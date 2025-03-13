import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/dashboard/components/pengukuran_card.dart';
import 'package:epenting/app/views/dashboard/components/pengukurancard_loading.dart';
import 'package:epenting/app/views/dashboard/widgets/pengukuran/pengukuran_header.dart';
import 'package:epenting/app/widgets/base_emptystate.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:epenting/app/widgets/base_loadscroll.dart';
import 'package:epenting/app/widgets/base_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class PengukuranPage extends StatelessWidget {
  const PengukuranPage({
    required this.selectedPengukuranDateFilter,
    required this.onPressedPengukuranDateFilter,
    required this.pengukuranScrollController,
    required this.onRefreshPengukuran,
    required this.searchPengukuranController,
    required this.onSearchPengukuran,
    required this.onPressedShowAllMonthPengukuran,
    super.key,
  });

  final DateTime? selectedPengukuranDateFilter;
  final void Function()? onPressedPengukuranDateFilter;
  final ScrollController pengukuranScrollController;
  final Future<void> Function() onRefreshPengukuran;
  final TextEditingController searchPengukuranController;
  final void Function(String?)? onSearchPengukuran;
  final void Function()? onPressedShowAllMonthPengukuran;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PengukuranHeader(
          selectedPengukuranDateFilter: selectedPengukuranDateFilter,
          onPressedPengukuranDateFilter: onPressedPengukuranDateFilter,
          searchPengukuranController: searchPengukuranController,
          onSearchPengukuran: onSearchPengukuran,
        ),
        Expanded(
          child: BlocBuilder<PengukuranCubit, PengukuranState>(
            builder: (context, state) {
              switch (state.pengukuranStatus) {
                case PengukuranStatus.error:
                  return BaseErrorstate(
                    message: state.pengukuranError,
                    messageSize: 14.sp,
                    lottieWidth: 180.w,
                    padding: const EdgeInsets.all(16),
                    onPressedRefresh: () {
                      context.read<PengukuranCubit>().refetchAllPengukuran();
                    },
                  );
                case PengukuranStatus.success:
                  return state.pengukurans.isEmpty &&
                          searchPengukuranController.text.isNotEmpty
                      ? BaseEmptyState(
                        message:
                            'Balita dengan nama "${searchPengukuranController.text.toUpperCase()}" tidak ditemukan',
                        totalData: '${state.pengukurans.length} Pengukuran',
                        showButton: false,
                      )
                      : state.pengukurans.isEmpty &&
                          selectedPengukuranDateFilter != null
                      ? BaseEmptyState(
                        message:
                            'Data pengukuran pada bulan ${AppHelpers.monthYearFormat(selectedPengukuranDateFilter ?? DateTime(0000))} kosong',
                        totalData: '${state.pengukurans.length} Pengukuran',
                        iconButton: MingCute.refresh_2_line,
                        labelButton: 'Tampilkan Semua Bulan',
                        onPressedButton: onPressedShowAllMonthPengukuran,
                      )
                      : state.pengukurans.isEmpty
                      ? BaseEmptyState(
                        message: 'Data Pengukuran Kosong',
                        totalData: '${state.pengukurans.length} Pengukuran',
                        onPressedButton: () {},
                      )
                      : BaseRefresh(
                        onRefresh: onRefreshPengukuran,
                        child:
                            searchPengukuranController.text.isEmpty
                                ? ListView.builder(
                                  controller: pengukuranScrollController,
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    16,
                                    16,
                                    80,
                                  ),
                                  itemCount:
                                      state.hasMorePengukuran
                                          ? state.pengukurans.length + 1
                                          : state.pengukurans.length,
                                  itemBuilder: (context, index) {
                                    return index >= state.pengukurans.length
                                        ? const BaseLoadScroll()
                                        : PengukuranCard(
                                          day:
                                              state.pengukurans[index].hari ??
                                              '',
                                          measureDate:
                                              state
                                                  .pengukurans[index]
                                                  .tanggalPenimbangan ??
                                              '',
                                          name:
                                              state
                                                  .pengukurans[index]
                                                  .namaAnak ??
                                              '',
                                          stanting:
                                              state
                                                  .pengukurans[index]
                                                  .stanting ??
                                              '',
                                          index: index,
                                          dataLength: state.pengukurans.length,
                                          onTap: () {},
                                        );
                                  },
                                )
                                : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    16,
                                    16,
                                    80,
                                  ),
                                  itemCount: state.pengukurans.length,
                                  itemBuilder: (context, index) {
                                    final pengukuran = state.pengukurans[index];

                                    return PengukuranCard(
                                      day: pengukuran.hari ?? '',
                                      measureDate:
                                          pengukuran.tanggalPenimbangan ?? '',
                                      name: pengukuran.namaAnak ?? '',
                                      stanting: pengukuran.stanting ?? '',
                                      index: index,
                                      dataLength: state.pengukurans.length,
                                      onTap: () {},
                                    );
                                  },
                                ),
                      );
                default:
                  return pengukuranCardLoading(25);
              }
            },
          ),
        ),
      ],
    );
  }
}
