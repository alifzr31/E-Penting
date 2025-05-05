import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/add_balita/addbalita_page.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BalitaHeader extends StatelessWidget {
  const BalitaHeader({
    required this.balitaFilters,
    required this.searchBalitaController,
    required this.onSearchBalita,
    super.key,
  });

  final List<String> balitaFilters;
  final TextEditingController searchBalitaController;
  final void Function(String?)? onSearchBalita;

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
                            'Kelola Data Balita',
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
                      controller: searchBalitaController,
                      prefixIcon: Icon(
                        MingCute.search_line,
                        size: 18.sp,
                        color: Colors.black,
                      ),
                      onChanged: onSearchBalita,
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      height: 30.h,
                      width: double.infinity,
                      child: BaseOutlineButtonIcon(
                        borderColor: AppColors.orangeColor,
                        fgColor: AppColors.orangeColor,
                        label: 'Balita Baru',
                        icon: MingCute.add_line,
                        onPressed: () {
                          Navigator.pushNamed(context, AddBalitaPage.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (searchBalitaController.text.isEmpty &&
            context.watch<BalitaCubit>().state.balitaStatus ==
                BalitaStatus.success)
          SizedBox(height: 10.h),
        if (searchBalitaController.text.isEmpty &&
            context.watch<BalitaCubit>().state.balitaStatus ==
                BalitaStatus.success)
          BlocBuilder<BalitaCubit, BalitaState>(
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
                child: Row(
                  children: List.generate(5, (index) {
                    final filter = balitaFilters[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == (balitaFilters.length - 1) ? 0 : 8,
                        bottom: 3,
                      ),
                      child: Material(
                        color:
                            state.selectedFilter == filter
                                ? AppColors.blueColor
                                : Colors.white,
                        elevation: 1,
                        shape: const StadiumBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            if (state.selectedFilter != filter) {
                              context.read<BalitaCubit>().refetchAllBalita(
                                filter: filter,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 16,
                            ),
                            child: Center(
                              child: Text(
                                filter == 'all'
                                    ? 'Semua Bulan'
                                    : '$filter Bulan',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight:
                                      state.selectedFilter == filter
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                  color:
                                      state.selectedFilter == filter
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
      ],
    );
  }
}
