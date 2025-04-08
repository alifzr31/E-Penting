import 'package:epenting/app/configs/get_it/service_locator.dart';
import 'package:epenting/app/configs/router/page_transition.dart';
import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/views/aktivasi_akun/aktivasiakun_page.dart';
import 'package:epenting/app/views/dashboard/dashboard_page.dart';
import 'package:epenting/app/views/detail_panduan/detailpanduan_page.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/views/onboard/onboard_page.dart';
import 'package:epenting/app/views/ortu/ortu_page.dart';
import 'package:epenting/app/views/splash/splash_page.dart';
import 'package:epenting/app/views/status_gizi/statusgizi_page.dart';
import 'package:epenting/app/views/update/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case SplashPage.routeName:
        return pageTransition(context, settings, child: const SplashPage());
      case UpdatePage.routeName:
        final args = settings.arguments as Map<String, dynamic>?;

        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: UpdatePage(appVersionResult: args?['appVersionResult']),
        );
      case OnboardPage.routeName:
        return pageTransition(context, settings, child: const OnboardPage());
      case LoginPage.routeName:
        return pageTransition(context, settings, child: const LoginPage());
      case AktivasiAkunPage.routeName:
        return pageTransition(
          context,
          settings,
          child: const AktivasiAkunPage(),
        );
      case StatusGiziPage.routeName:
        return pageTransition(
          context,
          settings,
          child: BlocProvider(
            create: (context) => sl<StatusGiziCubit>(),
            child: const StatusGiziPage(),
          ),
        );
      case DashboardPage.routeName:
        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<DashboardCubit>()),
              BlocProvider(create: (context) => sl<PengukuranCubit>()),
              BlocProvider(create: (context) => sl<ImunisasiCubit>()),
              BlocProvider(create: (context) => sl<BalitaCubit>()),
            ],
            child: const DashboardPage(),
          ),
        );
      case OrtuPage.routeName:
        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: BlocProvider(
            create: (context) => sl<OrtuCubit>(),
            child: const OrtuPage(),
          ),
        );
      case DetailPanduanPage.routeName:
        final args = settings.arguments as Map<String, dynamic>?;

        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: DetailPanduanPage(imageName: args?['imageName']),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Placeholder());
    }
  }
}
