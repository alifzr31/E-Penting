import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_balita.dart';
import 'package:epenting/app/views/dashboard/widgets/home/home_header.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    this.seeAllPengukuran,
    this.seeAllImunisasi,
    this.seeAllBalita,
    super.key,
  });

  final void Function()? seeAllPengukuran;
  final void Function()? seeAllImunisasi;
  final void Function()? seeAllBalita;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) {
            context.read<AuthCubit>().refetchProfile();
            context.read<DashboardCubit>().refetchPercentage();
            context.read<DashboardCubit>().refetchLatestBalita();
            context.read<DashboardCubit>().refetchLatestPengukuran();
            context.read<DashboardCubit>().refetchLatestImunisasi();
          }
        });
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: 80),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const HomeHeader(),
          SizedBox(height: 10.h),
          HomeBalita(seeAllBalita: seeAllBalita),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.white,
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pengukuran Terakhir',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: state.latestPengukurans.length,
                          itemBuilder: (context, index) {
                            final pengukuran = state.latestPengukurans[index];

                            return Card(
                              color: Colors.grey.shade200,
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              margin: EdgeInsets.only(
                                bottom:
                                    index ==
                                            (state.latestPengukurans.length - 1)
                                        ? 0
                                        : 6,
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pengukuran.hari ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            Text(
                                              pengukuran.tanggalPenimbangan ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              pengukuran.namaAnak ?? '',
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              pengukuran.stanting ?? '',
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppHelpers.stantingColor(
                                                  pengukuran.stanting,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            MingCute.right_line,
                                            size: 20.sp,
                                            color: AppColors.blueColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    BaseTextButton(
                      text: 'Lihat Semua',
                      size: 12.sp,
                      color: AppColors.orangeColor,
                      onPressed: seeAllPengukuran,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.white,
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Imunisasi Terakhir',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: state.latestImunisasis.length,
                          itemBuilder: (context, index) {
                            final imunisasi = state.latestImunisasis[index];

                            return Card(
                              color: Colors.grey.shade200,
                              elevation: 0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              margin: EdgeInsets.only(
                                bottom:
                                    index ==
                                            (state.latestPengukurans.length - 1)
                                        ? 0
                                        : 6,
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              imunisasi.hari ?? '',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            Text(
                                              imunisasi.tanggalImunisasi ?? '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            imunisasi.namaAnak ?? '',
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.indigo.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            MingCute.right_line,
                                            size: 20.sp,
                                            color: AppColors.blueColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    BaseTextButton(
                      text: 'Lihat Semua',
                      size: 12.sp,
                      color: AppColors.orangeColor,
                      onPressed: seeAllImunisasi,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
