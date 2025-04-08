import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/ortu/components/anakchoice_item.dart';
import 'package:epenting/app/views/ortu/components/ortuanakcard_loading.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class OrtuAnakCard extends StatelessWidget {
  const OrtuAnakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        switch (authState.profileStatus) {
          case ProfileStatus.success:
            return BlocBuilder<OrtuCubit, OrtuState>(
              builder: (context, state) {
                return ExpansionTileCard(
                  baseColor: Colors.white,
                  elevation: 1,
                  expandedColor: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  initialElevation: 1,
                  initialPadding: const EdgeInsets.symmetric(horizontal: 16),
                  finalPadding: const EdgeInsets.symmetric(horizontal: 16),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: CircleAvatar(
                    backgroundColor: AppHelpers.genderColor('laki-laki'),
                    radius: 20.r,
                    child: Center(
                      child: Icon(
                        AppHelpers.genderIcon('laki-laki'),
                        size: 24.r,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    state.selectedAnak?.nama ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    AppHelpers.ageYearAndMonth(
                      state.selectedAnak?.tanggalLahir ?? DateTime(0000),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  animateTrailing: true,
                  trailing: Icon(
                    MingCute.down_line,
                    size: 20.sp,
                    color: AppColors.orangeColor,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1, color: Colors.grey.shade300),
                    ),
                    SizedBox(height: 10.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, authState) {
                        return Container(
                          height:
                              (authState.profile?.listAnak?.length ?? 0) < 2
                                  ? null
                                  : 108.h,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                            shrinkWrap:
                                (authState.profile?.listAnak?.length ?? 0) < 2
                                    ? true
                                    : false,
                            physics: const ClampingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: authState.profile?.listAnak?.length,
                            itemBuilder: (context, index) {
                              final anak = authState.profile?.listAnak?[index];

                              return AnakChoiceItem(
                                selectedAnak: state.selectedAnak,
                                anakItem: anak,
                                onSelectedAnak: () {
                                  context.read<OrtuCubit>().selectAnak(anak);
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          default:
            return ortuAnakCardLoading();
        }
      },
    );
  }
}
