import 'dart:async';

import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/views/onboard/onboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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

  void _initTimer() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool openedOnboard = sharedPreferences.getBool('opened_onboard') ?? false;

    _timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        openedOnboard ? LoginPage.routeName : OnboardPage.routeName,
        (route) => false,
      );
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
