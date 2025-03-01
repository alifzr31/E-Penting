import 'dart:async';

import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/dashboard/dashboard_page.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/views/onboard/onboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final localAuthentication = LocalAuthentication();
  Timer? _timer;
  String? _appVersion;

  Future<void> _getPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        _appVersion = 'Versi ${packageInfo.version}';
      });
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<bool> _checkBiometrics() async {
    try {
      final canAuthenticateWithBiometrics =
          await localAuthentication.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics ||
          await localAuthentication.isDeviceSupported();

      return canAuthenticate;
    } on PlatformException catch (e) {
      if (kDebugMode) print(e.message);
      return false;
    }
  }

  Future<bool> _authFingerprint() async {
    try {
      final didAuthFingerprint = await localAuthentication.authenticate(
        localizedReason: 'Silahkan pindai sidik jari anda untuk melanjutkan',
        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'E-Penting',
            biometricHint: 'Masuk dengan sidik jari',
            cancelButton: 'Batal',
            biometricNotRecognized: 'Sidik jari tidak dikenali, coba lagi',
            biometricSuccess: 'Autentikasi berhasil',
          ),
        ],
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: true,
          useErrorDialogs: true,
        ),
      );

      return didAuthFingerprint;
    } on PlatformException catch (e) {
      if (kDebugMode) print(e.message);
      return false;
    }
  }

  void _initTimer() async {
    bool hasToken = await context.read<AuthCubit>().hasToken();
    final sharedPreferences = await SharedPreferences.getInstance();
    bool openedOnboard = sharedPreferences.getBool('opened_onboard') ?? false;

    _timer = Timer(const Duration(seconds: 2), () async {
      if (hasToken) {
        final canAuthenticate = await _checkBiometrics();

        if (canAuthenticate) {
          final didAuthFingerprint = await _authFingerprint();

          if (didAuthFingerprint) {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                DashboardPage.routeName,
                (route) => false,
              );
            }
          } else {
            SystemNavigator.pop();
          }
        } else {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              DashboardPage.routeName,
              (route) => false,
            );
          }
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          openedOnboard ? LoginPage.routeName : OnboardPage.routeName,
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    _getPackageInfo().then((value) {
      _initTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      '${AppStrings.assetsImages}/logo2.svg',
                      width: 120.w,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'E-Penting',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Elektronik',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      'Pendataan Stunting',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    _appVersion ?? '',
                    style: TextStyle(fontSize: 12.sp),
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
