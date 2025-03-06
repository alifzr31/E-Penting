import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/dashboard/components/pengukuran_card.dart';
import 'package:epenting/app/views/dashboard/components/pengukurancard_loading.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PengukuranPage extends StatelessWidget {
  const PengukuranPage({
    required this.selectedPengukuranDateFilter,
    required this.onPressedPengukuranDateFilter,
    required this.pengukuranScrollController,
    required this.onRefreshPengukuran,
    super.key,
  });

  final DateTime? selectedPengukuranDateFilter;
  final void Function()? onPressedPengukuranDateFilter;
  final ScrollController pengukuranScrollController;
  final Future<void> Function() onRefreshPengukuran;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wilujeng Siang',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              switch (state.profileStatus) {
                                case ProfileStatus.success:
                                  return Row(
                                    children: [
                                      Icon(MingCute.location_fill, size: 12.sp),
                                      SizedBox(width: 1.w),
                                      Expanded(
                                        child: Text(
                                          'Posyandu ${state.profile?.namaPosyandu}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                default:
                                  return Skeletonizer(
                                    child: Row(
                                      children: [
                                        Skeleton.keep(
                                          child: Icon(
                                            MingCute.location_fill,
                                            size: 12.sp,
                                          ),
                                        ),
                                        SizedBox(width: 1.w),
                                        Expanded(
                                          child: Text(
                                            'Posyandu xxxxxxxxxxxx',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                              }
                            },
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Kelola Data Pengukuran',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    BaseFormField(
                      hint: 'Cari berdasarkan nama balita',
                      prefixIcon: Icon(MingCute.search_line, size: 18.sp),
                      onChanged: (p0) {},
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 30.h,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll(
                                  AppColors.blueColor,
                                ),
                                iconColor: WidgetStatePropertyAll(
                                  AppColors.blueColor,
                                ),
                                overlayColor: WidgetStatePropertyAll(
                                  AppColors.blueColor.withValues(alpha: 0.1),
                                ),
                                side: WidgetStatePropertyAll(
                                  BorderSide(
                                    width: 1.3,
                                    color: AppColors.blueColor,
                                  ),
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                              onPressed: onPressedPengukuranDateFilter,
                              child:
                                  selectedPengukuranDateFilter == null
                                      ? Icon(
                                        MingCute.calendar_2_line,
                                        size: 20.sp,
                                      )
                                      : Text(
                                        DateFormat(
                                          'MMMM yyyy',
                                        ).format(selectedPengukuranDateFilter!),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          flex: selectedPengukuranDateFilter == null ? 3 : 2,
                          child: SizedBox(
                            height: 30.h,
                            child: BaseOutlineButtonIcon(
                              borderColor: AppColors.orangeColor,
                              fgColor: AppColors.orangeColor,
                              label: 'Pengukuran Baru',
                              icon: MingCute.add_line,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<PengukuranCubit, PengukuranState>(
            builder: (context, state) {
              switch (state.pengukuranStatus) {
                case PengukuranStatus.error:
                  return Center(child: Text(state.pengukuranError));
                case PengukuranStatus.success:
                  return RefreshIndicator(
                    onRefresh: onRefreshPengukuran,
                    child: ListView.builder(
                      controller: pengukuranScrollController,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                      itemCount:
                          state.hasMorePengukuran
                              ? state.pengukurans.length + 1
                              : state.pengukurans.length,
                      itemBuilder: (context, index) {
                        return index >= state.pengukurans.length
                            ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                            : PengukuranCard(
                              day: state.pengukurans[index].hari ?? '',
                              measureDate:
                                  state.pengukurans[index].tanggalPenimbangan ??
                                  '',
                              name: state.pengukurans[index].namaAnak ?? '',
                              stanting: state.pengukurans[index].stanting ?? '',
                              index: index,
                              dataLength: state.pengukurans.length,
                              onPressed: () {},
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
