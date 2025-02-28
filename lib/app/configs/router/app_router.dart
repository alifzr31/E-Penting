import 'package:epenting/app/configs/get_it/service_locator.dart';
import 'package:epenting/app/configs/router/fade_transition.dart';
import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/views/onboard/onboard_page.dart';
import 'package:epenting/app/views/splash/splash_page.dart';
import 'package:epenting/app/views/status_gizi/statusgizi_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(
    BuildContext context,
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case SplashPage.routeName:
        return fadeTransition(context, settings, child: const SplashPage());
      case OnboardPage.routeName:
        return fadeTransition(context, settings, child: const OnboardPage());
      case LoginPage.routeName:
        return fadeTransition(context, settings, child: const LoginPage());
      case StatusGiziPage.routeName:
        return fadeTransition(
          context,
          settings,
          child: BlocProvider(
            create: (context) => sl<StatusGiziCubit>(),
            child: const StatusGiziPage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) => const Placeholder());
    }
  }
}
