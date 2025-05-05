import 'package:epenting/app/configs/get_it/service_locator.dart';
import 'package:epenting/app/configs/router/page_transition.dart';
import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/views/add_balita/addbalita_page.dart';
import 'package:epenting/app/views/add_imunisasi/addimunisasi_page.dart';
import 'package:epenting/app/views/add_pengukuran/addpengukuran_page.dart';
import 'package:epenting/app/views/aktivasi_akun/aktivasiakun_page.dart';
import 'package:epenting/app/views/dashboard/dashboard_page.dart';
import 'package:epenting/app/views/detail_panduan/detailpanduan_page.dart';
import 'package:epenting/app/views/edit_balita/editbalita_page.dart';
import 'package:epenting/app/views/edit_imunisasi/editimunisasi_page.dart';
import 'package:epenting/app/views/edit_pengukuran/editpengukuran_page.dart';
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
          child: const DashboardPage(),
        );
      case AddPengukuranPage.routeName:
        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: const AddPengukuranPage(),
        );
      case EditPengukuranPage.routeName:
        final args = settings.arguments as Map<String, dynamic>?;

        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: EditPengukuranPage(idPengukuran: args?['idPengukuran']),
        );
      case AddImunisasiPage.routeName:
        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: const AddImunisasiPage(),
        );
      case EditImunisasiPage.routeName:
        final args = settings.arguments as Map<String, dynamic>?;

        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: EditImunisasiPage(idImunisasi: args?['idImunisasi']),
        );
      case AddBalitaPage.routeName:
        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: const AddBalitaPage(),
        );
      case EditBalitaPage.routeName:
        final args = settings.arguments as Map<String, dynamic>?;

        return pageTransition(
          context,
          settings,
          type: PageTransitionType.sharedAxisVertical,
          child: EditBalitaPage(balitaId: args?['balitaId']),
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
