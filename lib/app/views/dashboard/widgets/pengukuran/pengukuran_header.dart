import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/add_pengukuran/addpengukuran_page.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PengukuranHeader extends StatelessWidget {
  const PengukuranHeader({
    required this.selectedPengukuranDateFilter,
    required this.onPressedPengukuranDateFilter,
    required this.searchPengukuranController,
    required this.onSearchPengukuran,
    super.key,
  });

  final DateTime? selectedPengukuranDateFilter;
  final void Function()? onPressedPengukuranDateFilter;
  final TextEditingController searchPengukuranController;
  final void Function(String?)? onSearchPengukuran;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      BlocBuilder<DashboardCubit, DashboardState>(
                        builder: (context, state) {
                          return Text(
                            'Wilujeng ${state.greeting}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade600,
                            ),
                          );
                        },
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          switch (state.profileStatus) {
                            case ProfileStatus.success:
                              return Row(
                                children: [
                                  Icon(
                                    MingCute.location_fill,
                                    size: 12.sp,
                                    color: Colors.blue,
                                  ),
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
                                        color: Colors.blue,
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
                  controller: searchPengukuranController,
                  prefixIcon: Icon(
                    MingCute.search_line,
                    size: 18.sp,
                    color: Colors.black,
                  ),
                  onChanged: onSearchPengukuran,
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
                                  ? Icon(MingCute.calendar_2_line, size: 20.sp)
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
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AddPengukuranPage.routeName,
                            );
                          },
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
    );
  }
}
