import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/dashboard/components/home/header_percentage.dart';
import 'package:epenting/app/views/dashboard/components/home/header_profile.dart';
import 'package:epenting/app/views/dashboard/components/home/headerpercentage_loading.dart';
import 'package:epenting/app/views/dashboard/components/home/headerprofile_loading.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.dashboardKey, super.key});

  final GlobalKey<ScaffoldState> dashboardKey;

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
                  alignment: Alignment.centerRight,
                  child: BaseIconButton(
                    icon: MingCute.menu_line,
                    size: 20.sp,
                    color: AppColors.blueColor,
                    onPressed: () {
                      dashboardKey.currentState?.openEndDrawer();
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    switch (state.profileStatus) {
                      case ProfileStatus.success:
                        return HeaderProfile(name: state.profile?.name ?? '');
                      default:
                        return headerProfileLoading();
                    }
                  },
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      switch (state.percentageStatus) {
                        case PercentageStatus.error:
                          return BaseHorizontalErrorState(
                            message: state.percentageError,
                            messageSize: 12.sp,
                            lottieWidth: 80.w,
                          );
                        case PercentageStatus.success:
                          return HeaderPercentage(
                            maleTotal: state.percentages.last.total ?? 0,
                            femaleTotal: state.percentages.first.total ?? 0,
                          );
                        default:
                          return headerPercentageLoading();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
