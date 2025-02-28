import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

PageTransition<dynamic> fadeTransition(
  BuildContext context,
  RouteSettings settings, {
  required Widget child,
}) {
  return PageTransition(
    type: PageTransitionType.fade,
    childCurrent: context.currentRoute,
    settings: settings,
    curve: Curves.easeInOutCubic,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
    child: child,
  );
}
