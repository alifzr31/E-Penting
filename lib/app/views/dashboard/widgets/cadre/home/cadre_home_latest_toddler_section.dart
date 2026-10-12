import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_toddler_card.dart';
import 'package:e_penting/app/views/dashboard/components/cadre/home/latest_toddler_loading.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CadreHomeLatestToddlerSection extends StatelessWidget {
  const new({this.onSeeAllToddler, super.key});

  final VoidCallback? onSeeAllToddler;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const .symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Balita Terbaru',
                  style: TextStyle(fontSize: 16, fontWeight: .w600),
                ),
              ),
              const SizedBox(width: 10),
              BaseTextButton(text: 'Lihat Semua', onPressed: onSeeAllToddler),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 94,
          width: .infinity,
          child: BlocBuilder<ToddlerCubit, ToddlerState>(
            buildWhen: (previous, current) {
              return previous.latestToddlerStatus !=
                  current.latestToddlerStatus;
            },
            builder: (context, state) {
              switch (state.latestToddlerStatus) {
                case .error:
                  return Row(
                    mainAxisSize: .min,
                    mainAxisAlignment: .center,
                    children: [
                      Lottie.asset('${AppStrings.assetsLotties}/error.json'),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              state.latestToddlerErrorMessage ?? '',
                              textAlign: .center,
                              maxLines: 2,
                              overflow: .ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: .w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            CupertinoButton(
                              minimumSize: .zero,
                              padding: .zero,
                              onPressed: () {
                                context
                                    .read<ToddlerCubit>()
                                    .refetchLatestToddlers();
                              },
                              foregroundColor: AppColors.blueColor,
                              child: const Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Icon(RemixIcon.refreshLine, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'Muat Ulang',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: .w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                case .success:
                  return state.latestToddlers.isEmpty
                      ? Row(
                          mainAxisSize: .min,
                          mainAxisAlignment: .center,
                          children: [
                            Lottie.asset(
                              '${AppStrings.assetsLotties}/error.json',
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: .center,
                                children: [
                                  const Text(
                                    'Belum ada data balita :(',
                                    textAlign: .center,
                                    maxLines: 2,
                                    overflow: .ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: .w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  CupertinoButton(
                                    minimumSize: .zero,
                                    padding: .zero,
                                    onPressed: () {
                                      context
                                          .read<ToddlerCubit>()
                                          .refetchLatestToddlers();
                                    },
                                    foregroundColor: AppColors.blueColor,
                                    child: const Row(
                                      mainAxisAlignment: .center,
                                      children: [
                                        Icon(RemixIcon.refreshLine, size: 16),
                                        SizedBox(width: 4),
                                        Text(
                                          'Muat Ulang',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: .w500,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          scrollDirection: .horizontal,
                          padding: const .symmetric(horizontal: 16),
                          itemCount: state.latestToddlers.length,
                          itemBuilder: (context, index) {
                            final toddler = state.latestToddlers[index];

                            return LatestToddlerCard(
                              todddlerMonthAge: toddler.bulanUsia ?? 0,
                              toddlerName: toddler.namaAnak ?? '',
                              toddlerGender: toddler.jenisKelamin ?? '',
                              dataLength: state.latestToddlers.length,
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
                                      .refetchLatestToddlers();
                                }
                              },
                            );
                          },
                        );
                default:
                  return const LatestToddlerLoading();
              }
            },
          ),
        ),
      ],
    );
  }
}
