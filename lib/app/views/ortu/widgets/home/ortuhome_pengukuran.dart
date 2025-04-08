import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/ortu/components/home/pengukurantype_card.dart';
import 'package:epenting/app/views/ortu/components/home/pengukurantypecard_loading.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class OrtuHomePengukuran extends StatelessWidget {
  const OrtuHomePengukuran({required this.pengukuranHistory, super.key});

  final void Function()? pengukuranHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Pengukuran Terakhir',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  BaseTextButton(
                    text: 'Lihat Riwayat',
                    size: 12.sp,
                    color: AppColors.orangeColor,
                    onPressed: pengukuranHistory,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              BlocBuilder<OrtuCubit, OrtuState>(
                builder: (context, state) {
                  switch (state.latestPengukuranStatus) {
                    case LatestPengukuranStatus.error:
                      return BaseHorizontalErrorState(
                        message: state.latestPengukuranError,
                        lottieWidth: 86.w,
                      );
                    case LatestPengukuranStatus.success:
                      return Column(
                        children: [
                          Row(
                            children: [
                              PengukuranTypeCard(
                                icon: MingCute.dashboard_3_line,
                                title: 'Berat\nBadan',
                                value: '${state.latestPengukuran?.berat} kg',
                                bgColor: const Color(0xFF85DFC9),
                                iconColor: const Color(0xFF00A77C),
                              ),
                              SizedBox(width: 10.w),
                              PengukuranTypeCard(
                                icon: MingCute.fullscreen_2_line,
                                title: 'Tinggi\nBadan',
                                value: '${state.latestPengukuran?.tinggi} cm',
                                bgColor: const Color(0xFF81B5FE),
                                iconColor: const Color(0xFF126DFF),
                              ),
                              SizedBox(width: 10.w),
                              PengukuranTypeCard(
                                icon: MingCute.head_line,
                                title: 'Lingkar\nKepala',
                                value:
                                    '${state.latestPengukuran?.lingkarKepala} cm',
                                bgColor: const Color(0xFFFDB894),
                                iconColor: const Color(0xFFEB6E2B),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                'Pengukuran Terakhir :',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    AppHelpers.dayMonthYearFormat(
                                      state.latestPengukuran?.tanggalUkur ??
                                          DateTime(0000),
                                    ),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    default:
                      return pengukuranTypeCardLoading();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
