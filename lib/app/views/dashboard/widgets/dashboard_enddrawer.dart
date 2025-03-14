import 'package:app_settings/app_settings.dart';
import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

class DashboardEndDrawer extends StatelessWidget {
  const DashboardEndDrawer({
    required this.appName,
    required this.appVersion,
    required this.fingerprintSupported,
    required this.fingerprintEnabled,
    required this.availableBiometrics,
    this.onChangedFingerprint,
    super.key,
  });

  final String? appName;
  final String? appVersion;
  final bool fingerprintSupported;
  final bool fingerprintEnabled;
  final List<BiometricType> availableBiometrics;
  final void Function(bool)? onChangedFingerprint;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          bottomLeft: Radius.circular(10.r),
        ),
      ),
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColors.blueColor),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                switch (state.profileStatus) {
                  case ProfileStatus.success:
                    return Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.greyFormField,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 28.r,
                            backgroundImage:
                                Image.asset(
                                  '${AppStrings.assetsImages}/posyandu.png',
                                ).image,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Posyandu',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              Text(
                                state.profile?.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  default:
                    return Skeletonizer(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.greyFormField,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 28.r,
                              backgroundImage:
                                  Image.asset(
                                    '${AppStrings.assetsImages}/posyandu.png',
                                  ).image,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Posyandu',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                Text(
                                  'xxxxxxxxxxxxxxx',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                }
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  horizontalTitleGap: 8.w,
                  leading: Icon(
                    MingCute.information_line,
                    size: 22.sp,
                    color: AppColors.blueColor,
                  ),
                  title: Text(
                    'Info Aplikasi',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  onTap: () {
                    AppSettings.openAppSettings(type: AppSettingsType.settings);
                  },
                ),
                if (fingerprintSupported)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 1, color: Colors.grey.shade300),
                  ),
                if (fingerprintSupported)
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    horizontalTitleGap: 8.w,
                    leading: Icon(
                      MingCute.fingerprint_line,
                      size: 22.sp,
                      color: AppColors.blueColor,
                    ),
                    title: Text(
                      'Sidik Jari',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    subtitle:
                        availableBiometrics.isNotEmpty
                            ? null
                            : Text(
                              'Tidak ada sidik jari terdaftar diperangkat anda',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade600,
                              ),
                            ),
                    trailing:
                        availableBiometrics.isEmpty
                            ? null
                            : Transform.scale(
                              scale: 0.6.r,
                              child: Switch(
                                activeTrackColor: AppColors.blueColor,
                                activeColor: const Color(0xFFE2E6FC),
                                inactiveThumbColor: AppColors.blueColor,
                                inactiveTrackColor: const Color(0xFFE2E6FC),
                                trackOutlineColor: const WidgetStatePropertyAll(
                                  AppColors.blueColor,
                                ),
                                value: fingerprintEnabled,
                                onChanged: onChangedFingerprint,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: Colors.grey.shade300),
                ),
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
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    horizontalTitleGap: 8.w,
                    leading: Icon(
                      MingCute.exit_line,
                      size: 22.sp,
                      color: AppColors.blueColor,
                    ),
                    title: Text('Keluar', style: TextStyle(fontSize: 14.sp)),
                    onTap: () {
                      context.read<AuthCubit>().logout();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '$appName $appVersion',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
