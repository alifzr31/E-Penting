import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/views/ortu/components/imunisasi/ortuimunisasi_card.dart';
import 'package:epenting/app/views/ortu/components/imunisasi/ortuimunisasicard_loading.dart';
import 'package:epenting/app/widgets/base_emptystate.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class OrtuImunisasiHistory extends StatelessWidget {
  const OrtuImunisasiHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrtuCubit, OrtuState>(
      builder: (context, state) {
        switch (state.latestVaccineStatus) {
          case LatestVaccineStatus.error:
            return ExpansionTileCard(
              baseColor: Colors.white,
              elevation: 1,
              expandedColor: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              initialElevation: 1,
              initialPadding: const EdgeInsets.symmetric(horizontal: 16),
              finalPadding: const EdgeInsets.symmetric(horizontal: 16),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                'Riwayat Imunisasi',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              animateTrailing: true,
              trailing: Icon(MingCute.down_line, size: 20.sp),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: Colors.grey.shade300),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: BaseErrorstate(
                    message: state.latestVaccineError,
                    lottieWidth: 180.w,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    showButton: false,
                  ),
                ),
              ],
            );
          case LatestVaccineStatus.success:
            return ExpansionTileCard(
              baseColor: Colors.white,
              elevation: 1,
              expandedColor: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              initialElevation: 1,
              initialPadding: const EdgeInsets.symmetric(horizontal: 16),
              finalPadding: const EdgeInsets.symmetric(horizontal: 16),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                'Riwayat Imunisasi',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              animateTrailing: true,
              trailing: Icon(MingCute.down_line, size: 20.sp),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: Colors.grey.shade300),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: state.latestVaccines.isEmpty ? 230.h : 200.h,
                  width: double.infinity,
                  child:
                      state.latestVaccines.isEmpty
                          ? BaseEmptyState(
                            message: 'Belum ada imunisasi yang dilakukan :(',
                            totalData: '0 Imunisasi',
                            showButton: false,
                          )
                          : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 16,
                            ),
                            itemCount: state.latestVaccines.length,
                            itemBuilder: (context, index) {
                              final latestVaccine = state.latestVaccines[index];

                              return OrtuImunisasiCard(
                                imunisasiDate:
                                    latestVaccine.tanggalImunisasi ??
                                    DateTime(0000),
                                latestVaccines:
                                    latestVaccine.imunisasi ?? const [],
                                index: index,
                                dataLength: state.latestVaccines.length,
                              );
                            },
                          ),
                ),
                SizedBox(height: 4.h),
              ],
            );
          default:
            return ortuImunisasiCardLoading();
        }
      },
    );
  }
}
