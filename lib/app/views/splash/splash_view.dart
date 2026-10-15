import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart'
    hide Status;
import 'package:e_penting/app/cubits/splash/splash_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class SplashView extends StatefulWidget {
  const new({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().initApp();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) {
        final targetChanged =
            previous.target != current.target && current.target != .none;
        final errorOccurred =
            previous.errorMessage != current.errorMessage &&
            current.errorMessage != null;
        return targetChanged || errorOccurred;
      },
      listener: (context, state) {
        if (state.errorMessage != null) {
          showCustomToast(
            context,
            type: state.target == .login ? .error : .warning,
            title: state.target == .login
                ? 'Keamanan Sesi'
                : 'Informasi Sensor',
            description: state.errorMessage,
          );
        }

        switch (state.target) {
          case .update:
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.update,
              (route) => false,
            );
            break;
          case .onboard:
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.onboard,
              (route) => false,
            );
            break;
          case .login:
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.login,
              (route) => false,
            );
            break;
          case .dashboard:
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.dashboard,
              (route) => false,
            );
            break;
          case .none:
            break;
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: BlocBuilder<PackageInfoCubit, PackageInfoState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: .center,
                          children: [
                            SvgPicture.asset(
                              '${AppStrings.assetsImages}/logo2.svg',
                              width: 130,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.appName ?? '',
                              textAlign: .center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: .w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Elektronik\nPendataan Stunting',
                              textAlign: .center,
                              style: TextStyle(fontSize: 14, fontWeight: .w500),
                            ),
                            const SizedBox(height: 30),
                            BlocBuilder<SplashCubit, SplashState>(
                              builder: (context, splashState) {
                                if (splashState.isBiometricCancelled) {
                                  return BaseButtonIcon(
                                    icon: RemixIcon.fingerprint2Line,
                                    label: 'Masuk',
                                    onPressed: () async {
                                      context
                                          .read<SplashCubit>()
                                          .authenticateBiometric();
                                    },
                                  );
                                }

                                return const CircularProgressIndicator(
                                  color: AppColors.orangeColor,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Text(
                          state.appVersion != null
                              ? 'Versi ${state.appVersion} (${state.appBuildNumber})'
                              : '',
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
