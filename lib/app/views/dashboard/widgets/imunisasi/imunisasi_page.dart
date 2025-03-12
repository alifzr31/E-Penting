import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/dashboard/components/imunisasi_card.dart';
import 'package:epenting/app/views/dashboard/components/imunisasicard_loading.dart';
import 'package:epenting/app/views/dashboard/widgets/imunisasi/imunisasi_header.dart';
import 'package:epenting/app/widgets/base_emptystate.dart';
import 'package:epenting/app/widgets/base_loadscroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class ImunisasiPage extends StatelessWidget {
  const ImunisasiPage({
    required this.selectedImunisasiDateFilter,
    required this.onPressedImunisasiDateFilter,
    required this.imunisasiScrollController,
    required this.onRefreshImunisasi,
    required this.searchImunisasiController,
    required this.onSearchImunisasi,
    required this.onPressedShowAllMonthImunisasi,
    super.key,
  });

  final DateTime? selectedImunisasiDateFilter;
  final void Function()? onPressedImunisasiDateFilter;
  final ScrollController imunisasiScrollController;
  final Future<void> Function() onRefreshImunisasi;
  final TextEditingController searchImunisasiController;
  final void Function(String?)? onSearchImunisasi;
  final void Function()? onPressedShowAllMonthImunisasi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImunisasiHeader(
          selectedImunisasiDateFilter: selectedImunisasiDateFilter,
          onPressedImunisasiDateFilter: onPressedImunisasiDateFilter,
          searchImunisasiController: searchImunisasiController,
          onSearchImunisasi: onSearchImunisasi,
        ),
        Expanded(
          child: BlocBuilder<ImunisasiCubit, ImunisasiState>(
            builder: (context, state) {
              switch (state.imunisasiStatus) {
                case ImunisasiStatus.error:
                  return Center(child: Text(state.imunisasiError));
                case ImunisasiStatus.success:
                  return state.imunisasis.isEmpty &&
                          searchImunisasiController.text.isNotEmpty
                      ? BaseEmptyState(
                        message:
                            'Balita dengan nama "${searchImunisasiController.text.toUpperCase()}" tidak ditemukan',
                        totalData: '${state.imunisasis.length} Pengukuran',
                        showButton: false,
                      )
                      : state.imunisasis.isEmpty &&
                          selectedImunisasiDateFilter != null
                      ? BaseEmptyState(
                        message:
                            'Data imunisasi pada bulan ${AppHelpers.monthYearFormat(selectedImunisasiDateFilter ?? DateTime(0000))} kosong',
                        totalData: '${state.imunisasis.length} Pengukuran',
                        iconButton: MingCute.refresh_2_line,
                        labelButton: 'Tampilkan Semua Bulan',
                        onPressedButton: onPressedShowAllMonthImunisasi,
                      )
                      : state.imunisasis.isEmpty
                      ? BaseEmptyState(
                        message: 'Data Pengukuran Kosong',
                        totalData: '${state.imunisasis.length} Pengukuran',
                        onPressedButton: () {},
                      )
                      : RefreshIndicator(
                        onRefresh: onRefreshImunisasi,
                        child:
                            searchImunisasiController.text.isEmpty
                                ? ListView.builder(
                                  controller: imunisasiScrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    16,
                                    16,
                                    80,
                                  ),
                                  itemCount:
                                      state.hasMoreImunisasi
                                          ? state.imunisasis.length + 1
                                          : state.imunisasis.length,
                                  itemBuilder: (context, index) {
                                    return index >= state.imunisasis.length
                                        ? const BaseLoadScroll()
                                        : ImunisasiCard(
                                          day:
                                              state.imunisasis[index].hari ??
                                              '',
                                          date:
                                              state
                                                  .imunisasis[index]
                                                  .tanggalImunisasi ??
                                              '',
                                          name:
                                              state
                                                  .imunisasis[index]
                                                  .namaAnak ??
                                              '',
                                          index: index,
                                          dataLength: state.imunisasis.length,
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
                                  itemCount: state.imunisasis.length,
                                  itemBuilder: (context, index) {
                                    final imunisasi = state.imunisasis[index];

                                    return ImunisasiCard(
                                      day: imunisasi.hari ?? '',
                                      date: imunisasi.tanggalImunisasi ?? '',
                                      name: imunisasi.namaAnak ?? '',
                                      index: index,
                                      dataLength: state.imunisasis.length,
                                      onTap: () {},
                                    );
                                  },
                                ),
                      );
                default:
                  return imunisasiCardLoading(25);
              }
            },
          ),
        ),
      ],
    );
  }
}
