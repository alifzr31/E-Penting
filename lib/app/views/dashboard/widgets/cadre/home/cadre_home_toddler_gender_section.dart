import 'package:e_penting/app/cubits/stat/stat_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/toddler_gender_graph.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/toddler_gender_graph_loading.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CadreHomeToddlerGenderSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: SizedBox(
        width: .infinity,
        child: Material(
          clipBehavior: .antiAlias,
          borderRadius: .circular(10),
          color: AppColors.orangeColor.withValues(alpha: 0.15),
          child: Padding(
            padding: const .all(16),
            child: BlocBuilder<StatCubit, StatState>(
              buildWhen: (previous, current) {
                return previous.percentageStatus != current.percentageStatus;
              },
              builder: (context, state) {
                switch (state.percentageStatus) {
                  case .error:
                    return BaseHandleState(
                      handleType: .error,
                      lottieWidth: 100,
                      errorMessageSize: 12,
                      iconButtonSize: 16,
                      labelButtonSize: 12,
                      errorMessage: state.percentageErrorMessage ?? '',
                      onRefetch: () {
                        context.read<StatCubit>().refetchPercentage();
                      },
                    );
                  case .success:
                    if (state.percentage.isEmpty) {
                      return const ToddlerGenderGraph(
                        totalMale: 0,
                        percentageMale: 0,
                        totalFemale: 0,
                        percentageFemale: 0,
                      );
                    }

                    final malePercentage = state.percentage.firstWhere((
                      element,
                    ) {
                      return element.jenisKelamin?.toLowerCase() == 'laki-laki';
                    });
                    final femalePercentage = state.percentage.firstWhere((
                      element,
                    ) {
                      return element.jenisKelamin?.toLowerCase() == 'perempuan';
                    });

                    return ToddlerGenderGraph(
                      totalMale: malePercentage.total ?? 0,
                      percentageMale: malePercentage.percent ?? 0,
                      totalFemale: femalePercentage.total ?? 0,
                      percentageFemale: femalePercentage.percent ?? 0,
                    );
                  default:
                    return const ToddlerGenderGraphLoading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
