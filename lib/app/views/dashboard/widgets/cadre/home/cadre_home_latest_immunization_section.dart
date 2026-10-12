import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_immunization_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_immunization_card_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreHomeLatestImmunizationSection extends StatelessWidget {
  const new({this.onSeeAllImmunization, super.key});

  final VoidCallback? onSeeAllImmunization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(left: 16, right: 16, bottom: 16),
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
              BaseTextButton(
                text: 'Lihat Semua',
                onPressed: onSeeAllImmunization,
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<ImmunizationCubit, ImmunizationState>(
            buildWhen: (previous, current) {
              return previous.latestImmunizationStatus !=
                  current.latestImmunizationStatus;
            },
            builder: (context, state) {
              switch (state.latestImmunizationStatus) {
                case .error:
                  return SafeArea(
                    top: false,
                    child: BaseHandleState(
                      handleType: .error,
                      errorMessage: state.latestImmunizationErrorMessage ?? '',
                      lottieWidth: 160,
                      onRefetch: () {
                        context
                            .read<ImmunizationCubit>()
                            .refetchLatestImmunizations();
                      },
                    ),
                  );
                case .success:
                  return state.latestImmunizations.isEmpty
                      ? SafeArea(
                          top: false,
                          child: BaseHandleState(
                            handleType: .empty,
                            lottieWidth: 160,
                            errorMessage: 'Belum ada data pengukuran :(',
                            onRefetch: () {
                              context
                                  .read<ImmunizationCubit>()
                                  .refetchLatestImmunizations();
                            },
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: .zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.latestImmunizations.length,
                          itemBuilder: (context, index) {
                            final immunization =
                                state.latestImmunizations[index];

                            return LatestImmunizationCard(
                              toddlerName: immunization.namaAnak ?? ' ',
                              immunizationDay: immunization.hari ?? '',
                              immunizationDate:
                                  immunization.tanggalImunisasi ?? '',
                              dataLength: state.latestImmunizations.length,
                              index: index,
                              onTap: () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  RouteName.editImmunization,
                                  arguments: immunization.idImunisasi,
                                );

                                if (!context.mounted || result == null) {
                                  return;
                                }

                                final isSuccess = result as bool;

                                if (isSuccess) {
                                  context
                                      .read<ImmunizationCubit>()
                                      .refetchLatestImmunizations();
                                }
                              },
                            );
                          },
                        );
                default:
                  return const LatestImmunizationCardLoading();
              }
            },
          ),
        ],
      ),
    );
  }
}
