import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/views/dashboard/components/balita/balita_card.dart';
import 'package:epenting/app/views/dashboard/components/balita/balitacard_loading.dart';
import 'package:epenting/app/views/dashboard/widgets/balita/balita_header.dart';
import 'package:epenting/app/views/edit_balita/editbalita_page.dart';
import 'package:epenting/app/widgets/base_emptystate.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:epenting/app/widgets/base_loadscroll.dart';
import 'package:epenting/app/widgets/base_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalitaPage extends StatelessWidget {
  const BalitaPage({
    required this.balitaFilters,
    required this.balitaScrollController,
    required this.onRefreshBalita,
    required this.searchBalitaController,
    required this.onSearchBalita,
    super.key,
  });

  final List<String> balitaFilters;
  final ScrollController balitaScrollController;
  final Future<void> Function() onRefreshBalita;
  final TextEditingController searchBalitaController;
  final void Function(String?)? onSearchBalita;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BalitaHeader(
          balitaFilters: balitaFilters,
          searchBalitaController: searchBalitaController,
          onSearchBalita: onSearchBalita,
        ),
        Expanded(
          child: BlocBuilder<BalitaCubit, BalitaState>(
            builder: (context, state) {
              switch (state.balitaStatus) {
                case BalitaStatus.error:
                  return BaseErrorstate(
                    message: state.balitaError,
                    messageSize: 14.sp,
                    lottieWidth: 180.w,
                    padding: const EdgeInsets.all(16),
                    onPressedRefresh: () {
                      context.read<BalitaCubit>().refetchAllBalita();
                    },
                  );
                case BalitaStatus.success:
                  return state.balitas.isEmpty &&
                          searchBalitaController.text.isNotEmpty
                      ? BaseEmptyState(
                        message:
                            'Balita dengan nama "${searchBalitaController.text.toUpperCase()}" tidak ditemukan',
                        totalData: '${state.balitas.length} Balita',
                        showButton: false,
                      )
                      : state.balitas.isEmpty && state.selectedFilter != 'all'
                      ? BaseEmptyState(
                        message:
                            'Balita dengan rentang usia ${state.selectedFilter} bulan tidak ditemukan',
                        totalData: '${state.balitas.length} Balita',
                        showButton: false,
                      )
                      : state.balitas.isEmpty
                      ? BaseEmptyState(
                        message: 'Data Balita Kosong',
                        totalData: '${state.balitas.length} balita',
                        onPressedButton: () {},
                      )
                      : BaseRefresh(
                        onRefresh: onRefreshBalita,
                        child:
                            searchBalitaController.text.isEmpty
                                ? ListView.builder(
                                  controller: balitaScrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    10,
                                    16,
                                    80,
                                  ),
                                  itemCount:
                                      state.hasMoreBalita
                                          ? state.balitas.length + 1
                                          : state.balitas.length,
                                  itemBuilder: (context, index) {
                                    return index >= state.balitas.length
                                        ? const BaseLoadScroll()
                                        : BalitaCard(
                                          name:
                                              state.balitas[index].namaAnak ??
                                              '',
                                          gender:
                                              state
                                                  .balitas[index]
                                                  .jenisKelamin ??
                                              '',
                                          childCount:
                                              state.balitas[index].anakKe ?? 0,
                                          age:
                                              state.balitas[index].bulanUsia ??
                                              0,
                                          height:
                                              state.balitas[index].tinggi ?? 0,
                                          weight:
                                              state.balitas[index].beratLahir ??
                                              0,
                                          index: index,
                                          dataLength: state.balitas.length,
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              EditBalitaPage.routeName,
                                              arguments: {
                                                'balitaId':
                                                    state.balitas[index].id,
                                              },
                                            );
                                          },
                                        );
                                  },
                                )
                                : ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    10,
                                    16,
                                    80,
                                  ),
                                  itemCount: state.balitas.length,
                                  itemBuilder: (context, index) {
                                    final balita = state.balitas[index];

                                    return BalitaCard(
                                      name: balita.namaAnak ?? '',
                                      gender: balita.jenisKelamin ?? '',
                                      childCount: balita.anakKe ?? 0,
                                      age: balita.bulanUsia ?? 0,
                                      height: balita.tinggi ?? 0,
                                      weight: balita.beratLahir ?? 0,
                                      index: index,
                                      dataLength: state.balitas.length,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          EditBalitaPage.routeName,
                                          arguments: {'balitaId': balita.id},
                                        );
                                      },
                                    );
                                  },
                                ),
                      );
                default:
                  return balitaCardLoading();
              }
            },
          ),
        ),
      ],
    );
  }
}
