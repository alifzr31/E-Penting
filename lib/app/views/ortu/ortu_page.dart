import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/models/vaccine.dart';
import 'package:epenting/app/views/ortu/widgets/home/ortuhome_page.dart';
import 'package:epenting/app/views/ortu/widgets/imunisasi/ortuimunisasi_page.dart';
import 'package:epenting/app/views/ortu/widgets/tumbuh_kembang/ortukembang_page.dart';
import 'package:epenting/app/widgets/base_bottomnav.dart';
import 'package:epenting/app/widgets/base_enddrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrtuPage extends StatefulWidget {
  const OrtuPage({super.key});

  static const String routeName = '/ortu';

  @override
  State<OrtuPage> createState() => _OrtuPageState();
}

class _OrtuPageState extends State<OrtuPage> {
  final _ortuKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  String? _appName;
  String? _appVersion;
  bool fingerprintSupported = false;
  List<BiometricType> availableBiometrics = const [];
  bool fingerprintEnabled = false;

  final panduans = const [
    '29 Hari - 3 Bulan',
    '3 - 6 Bulan',
    '6 - 9 Bulan',
    '9 - 12 Bulan',
    '12 - 18 Bulan',
    '18 - 24 Bulan',
    '2 - 3 Tahun',
    '3 - 4 Tahun',
    '4 - 5 Tahun',
    '5 - 6 Tahun',
  ];

  final vaccines = const [
    Vaccine(name: 'HB', id: 'hb'),
    Vaccine(name: 'DPT-HB 1', id: 'dpt_hb1'),
    Vaccine(name: 'DPT-HB 2', id: 'dpt_hb2'),
    Vaccine(name: 'DPT-HB 3', id: 'dpt_hb3'),
    Vaccine(name: 'DPT-HB L', id: 'dpt_hbl'),
    Vaccine(name: 'Polio 1', id: 'polio1'),
    Vaccine(name: 'Polio 2', id: 'polio2'),
    Vaccine(name: 'Polio 3', id: 'polio3'),
    Vaccine(name: 'Polio 4', id: 'polio4'),
    Vaccine(name: 'Campak', id: 'campak'),
    Vaccine(name: 'Campak L', id: 'campak_l'),
    Vaccine(name: 'BCG', id: 'bcg'),
    Vaccine(name: 'IPV 1', id: 'ipv_1'),
    Vaccine(name: 'IPV 2', id: 'ipv_2'),
    Vaccine(name: 'ROTAV 1', id: 'rotav_1'),
    Vaccine(name: 'ROTAV 2', id: 'rotav_2'),
    Vaccine(name: 'ROTAV 3', id: 'rotav_3'),
    Vaccine(name: 'PCV 1', id: 'pcv_1'),
    Vaccine(name: 'PCV 2', id: 'pcv_2'),
    Vaccine(name: 'PCV 3', id: 'pcv_3'),
  ];

  Future<void> _getPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        _appName = packageInfo.appName;
        _appVersion = 'v${packageInfo.version}';
      });
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<void> _checkBiometrics() async {
    LocalAuthentication localAuthentication = LocalAuthentication();

    try {
      final canAuthenticateWithBiometrics =
          await localAuthentication.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics ||
          await localAuthentication.isDeviceSupported();
      final availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      setState(() {
        fingerprintSupported = canAuthenticate;
        this.availableBiometrics = availableBiometrics;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) print(e.message);
    }
  }

  Future<void> _checkFingerprintEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool enabled = prefs.getBool('fingerprint_enabled') ?? false;

    setState(() {
      fingerprintEnabled = enabled;
    });
  }

  Future<void> _setFingerprint(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fingerprint_enabled', value);
    await prefs.reload();

    setState(() {
      fingerprintEnabled = value;
    });
  }

  Future<bool> _authFingerprint() async {
    LocalAuthentication localAuthentication = LocalAuthentication();

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

  void _initOrtu() async {
    await _getPackageInfo();
    await _checkBiometrics();
    await _checkFingerprintEnabled();
  }

  @override
  void initState() {
    _initOrtu();
    context.read<AuthCubit>().fetchProfile().then((value) {
      if (mounted) {
        context.read<OrtuCubit>().selectAnak(
          context.read<AuthCubit>().state.profile?.listAnak?.first,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_currentPage == 0) {
            if (_ortuKey.currentState?.isEndDrawerOpen ?? false) {
              _ortuKey.currentState?.closeEndDrawer();
            } else {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          } else {
            setState(() {
              _currentPage = 0;
            });
          }
        }
      },
      child: Scaffold(
        key: _ortuKey,
        extendBody: true,
        resizeToAvoidBottomInset: _currentPage == 0 ? null : false,
        endDrawer: BaseEndDrawer(
          appName: _appName,
          appVersion: _appVersion,
          fingerprintSupported: fingerprintSupported,
          fingerprintEnabled: fingerprintEnabled,
          availableBiometrics: availableBiometrics,
          onChangedFingerprint: (value) {
            if (fingerprintEnabled) {
              _setFingerprint(value);
            } else {
              _authFingerprint().then((didAuth) {
                if (didAuth) {
                  _setFingerprint(value);
                }
              });
            }
          },
        ),
        bottomNavigationBar: BaseBottomNav(
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                _currentPage == 0 ? MingCute.home_3_fill : MingCute.home_3_line,
                size: 21.sp,
              ),
              title: Text(
                'Beranda',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                _currentPage == 1
                    ? BoxIcons.bxs_first_aid
                    : BoxIcons.bx_first_aid,
                size: 21.sp,
              ),
              title: Text(
                'Imunisasi',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                _currentPage == 2
                    ? MingCute.chart_vertical_fill
                    : MingCute.chart_vertical_line,
                size: 21.sp,
              ),
              title: Text(
                'Tumbuh Kembang',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
          currentPage: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
        body: IndexedStack(
          index: _currentPage,
          children: [
            OrtuHomePage(
              ortuKey: _ortuKey,
              pengukuranHistory: () {
                setState(() {
                  _currentPage = 2;
                });
              },
              imunisasiHistory: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              panduans: panduans,
            ),
            OrtuImunisasiPage(vaccines: vaccines),
            const OrtuKembangPage(),
          ],
        ),
      ),
    );
  }
}
