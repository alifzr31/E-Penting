import 'package:app_settings/app_settings.dart';
import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/views/dashboard/components/home/header_percentage.dart';
import 'package:epenting/app/views/dashboard/components/home/header_profile.dart';
import 'package:epenting/app/views/dashboard/components/home/headerpercentage_loading.dart';
import 'package:epenting/app/views/dashboard/components/home/headerprofile_loading.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BaseIconButton(
                      icon: MingCute.information_line,
                      size: 20.sp,
                      onPressed:
                          () => AppSettings.openAppSettings(
                            type: AppSettingsType.settings,
                          ),
                    ),
                    SizedBox(width: 6.w),
                    BlocListener<AuthCubit, AuthState>(
                      listenWhen:
                          (previous, current) =>
                              previous.logoutStatus != current.logoutStatus,
                      listener: (context, state) {
                        if (state.logoutStatus == LogoutStatus.loading) {
                          context.loaderOverlay.show();
                        }

                        if (state.logoutStatus == LogoutStatus.success) {
                          context.loaderOverlay.hide();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.routeName,
                            (route) => false,
                          );
                          context.read<AuthCubit>().resetState();
                        }

                        if (state.logoutStatus == LogoutStatus.error) {
                          context.loaderOverlay.hide();
                          showCustomToast(
                            context,
                            type: ToastificationType.error,
                            title: 'Keluar Gagal',
                            description: state.logoutError,
                          );
                        }
                      },
                      child: BaseIconButton(
                        icon: MingCute.exit_line,
                        size: 20.sp,
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                      ),
                    ),
                  ],
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
                          return Center(child: Text(state.percentageError));
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
