import 'package:app_settings/app_settings.dart';
import 'package:e_penting/app/configs/firebase/firebase_notification.dart';
import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/configs/local_notification/local_notification.dart';
import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    as pic;
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/widgets/base_listtile.dart';
import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardEndDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.logoutStatus != current.logoutStatus,
      listener: (context, state) {
        switch (state.logoutStatus) {
          case .loading:
            context.loaderOverlay.show();
          case .success:
            context.loaderOverlay.hide();

            final name = state.profile?.level == 'kader_posyandu'
                ? 'Posyandu ${state.profile?.name?.capitalize()}'
                : state.profile?.name;

            showCustomToast(
              context,
              type: .success,
              title: 'Keluar Berhasil',
              description: 'Sampai jumpa lagi $name!',
            );
            context.read<AuthCubit>().resetState();
            Navigator.pushReplacementNamed(context, RouteName.login);
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Keluar Gagal',
              description: state.logoutErrorMessage,
            );
          default:
            return;
        }
      },
      child: Drawer(
        backgroundColor: Colors.white,
        clipBehavior: .antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: .only(
            topLeft: .circular(10),
            bottomLeft: .circular(10),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              DrawerHeader(
                padding: const .all(16),
                margin: .zero,
                decoration: const BoxDecoration(color: AppColors.orangeColor),
                child: SizedBox(
                  width: .infinity,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.profileStatus != current.profileStatus,
                    builder: (context, state) {
                      switch (state.profileStatus) {
                        case .success:
                          final level = state.profile?.level;
                          final name = level == 'kader_posyandu'
                              ? 'Posyandu ${state.profile?.name?.capitalize()}'
                              : state.profile?.name;

                          return Row(
                            children: [
                              level == 'orangtua'
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      padding: const .all(8),
                                      decoration: const BoxDecoration(
                                        shape: .circle,
                                        color: Colors.white,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          RemixIcon.user6Fill,
                                          size: 50,
                                          color: AppColors.orangeColor,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        shape: .circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          '${AppStrings.assetsImages}/posyandu.png',
                                        ),
                                      ),
                                    ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: .center,
                                  crossAxisAlignment: .start,
                                  children: [
                                    const Text(
                                      'Halo!',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: .w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      name ?? '',
                                      maxLines: 1,
                                      overflow: .ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: .w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      state.profile?.username?.maskUsername() ??
                                          '',
                                      maxLines: 1,
                                      overflow: .ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: .w500,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        default:
                          return Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                foregroundDecoration: const BoxDecoration(
                                  shape: .circle,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Expanded(
                                child: BaseSkeletonizer(
                                  child: Column(
                                    mainAxisAlignment: .center,
                                    crossAxisAlignment: .start,
                                    children: [
                                      Skeleton.keep(
                                        child: Text(
                                          'Halo!',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: .w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'xxxxxxxxxxxxxx',
                                        maxLines: 1,
                                        overflow: .ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: .w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                                        maxLines: 1,
                                        overflow: .ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: .w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const .only(bottom: 16),
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      BlocBuilder<pic.PackageInfoCubit, pic.PackageInfoState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) {
                          return BaseListTile(
                            leading: const Icon(
                              RemixIcon.informationLine,
                              size: 24,
                            ),
                            title: 'Info Aplikasi',
                            subtitle: 'Versi ${state.appVersion}',
                            trailing: const Icon(
                              RemixIcon.arrowRightWideLine,
                              size: 16,
                            ),
                            onTap: () async {
                              try {
                                await AppSettings.openAppSettings(
                                  type: .settings,
                                );
                              } catch (e) {
                                if (kDebugMode) print(e);
                              }
                            },
                          );
                        },
                      ),
                      Padding(
                        padding: const .symmetric(horizontal: 16),
                        child: Divider(height: 1, color: Colors.grey.shade300),
                      ),
                      BaseListTile(
                        leading: const Icon(
                          RemixIcon.fingerprintLine,
                          size: 24,
                        ),
                        title: 'Sidik Jari',
                        trailing: Transform.scale(
                          scale: 0.6,
                          child: Switch(
                            padding: .zero,
                            activeThumbColor: AppColors.orangeColor.withValues(
                              alpha: 0.2,
                            ),
                            activeTrackColor: AppColors.orangeColor,
                            inactiveThumbColor: AppColors.orangeColor,
                            inactiveTrackColor: AppColors.orangeColor
                                .withValues(alpha: 0.2),
                            trackOutlineColor: const WidgetStatePropertyAll(
                              AppColors.orangeColor,
                            ),
                            value: false,
                            onChanged: (value) async {},
                          ),
                        ),
                      ),
                      if (kDebugMode) ...[
                        Padding(
                          padding: const .symmetric(horizontal: 16),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        BaseListTile(
                          leading: const Icon(
                            RemixIcon.notification3Line,
                            size: 24,
                          ),
                          title: 'Test Notifikasi',
                          onTap: () async {
                            final deviceToken = await sl<FirebaseNotification>()
                                .getDeviceToken();

                            await sl<LocalNotification>().showNotifications(
                              id: 1,
                              title: 'Test Notifikasi',
                              body: 'Contoh test notifikasi',
                            );

                            if (kDebugMode) print(deviceToken);
                          },
                        ),
                      ],
                      Padding(
                        padding: const .symmetric(horizontal: 16),
                        child: Divider(height: 1, color: Colors.grey.shade300),
                      ),
                      BaseListTile(
                        leading: const Icon(RemixIcon.doorClosedLine, size: 24),
                        title: 'Keluar',
                        onTap: () {
                          context.read<AuthCubit>().logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
