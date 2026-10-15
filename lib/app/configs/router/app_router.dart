import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/views/create_immunization/create_immunization_page.dart';
import 'package:e_penting/app/views/create_measurement/create_measurement_page.dart';
import 'package:e_penting/app/views/create_toddler/create_toddler_page.dart';
import 'package:e_penting/app/views/dashboard/dashboard_page.dart';
import 'package:e_penting/app/views/detail_guide/detail_guide_page.dart';
import 'package:e_penting/app/views/edit_immunization/edit_immunization_page.dart';
import 'package:e_penting/app/views/edit_measurement/edit_measurement_page.dart';
import 'package:e_penting/app/views/edit_toddler/edit_toddler_page.dart';
import 'package:e_penting/app/views/forbidden/forbidden_page.dart';
import 'package:e_penting/app/views/login/login_page.dart';
import 'package:e_penting/app/views/nutrition/nutrition_page.dart';
import 'package:e_penting/app/views/onboard/onboard_page.dart';
import 'package:e_penting/app/views/splash/splash_page.dart';
import 'package:e_penting/app/views/update/update_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const SplashPage();
          },
        );
      case RouteName.forbidden:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const ForbiddenPage();
          },
        );
      case RouteName.update:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const UpdatePage();
          },
        );
      case RouteName.onboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const OnboardPage();
          },
        );
      case RouteName.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const LoginPage();
          },
        );
      case RouteName.nutrition:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const NutritionPage();
          },
        );
      case RouteName.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const DashboardPage();
          },
        );
      case RouteName.detailGuide:
        final imageName = settings.arguments as String?;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return DetailGuidePage(imageName: imageName);
          },
        );
      case RouteName.createMeasurement:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const CreateMeasurementPage();
          },
        );
      case RouteName.editMeasurement:
        final measurementId = settings.arguments as int;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return EditMeasurementPage(measurementId: measurementId);
          },
        );
      case RouteName.createImmunization:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const CreateImmunizationPage();
          },
        );
      case RouteName.editImmunization:
        final immunizationId = settings.arguments as int;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return EditImmunizationPage(immunizationId: immunizationId);
          },
        );
      case RouteName.createToddler:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const CreateToddlerPage();
          },
        );
      case RouteName.editToddler:
        final toddlerId = settings.arguments as int;

        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return EditToddlerPage(toddlerId: toddlerId);
          },
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const Placeholder();
          },
        );
    }
  }
}
