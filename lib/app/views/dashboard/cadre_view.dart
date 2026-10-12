import 'dart:io' show exit;

import 'package:e_penting/app/views/dashboard/widgets/cadre/cadre_bottom_nav.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/cadre_home.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/cadre_immunization.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/cadre_measurement.dart';
import 'package:e_penting/app/views/dashboard/widgets/cadre/cadre_toddler.dart';
import 'package:e_penting/app/views/dashboard/widgets/dashboard_end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;

class CadreView extends StatefulWidget {
  const new({super.key});

  @override
  State<CadreView> createState() => _CadreViewState();
}

class _CadreViewState extends State<CadreView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;

  void _onTabChange(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
          _scaffoldKey.currentState?.closeEndDrawer();
        } else {
          await SystemNavigator.pop();
          exit(0);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        endDrawer: const DashboardEndDrawer(),
        bottomNavigationBar: CadreBottomNav(
          currentTab: _currentTab,
          onTabChange: _onTabChange,
        ),
        body: IndexedStack(
          index: _currentTab,
          children: [
            CadreHome(
              scaffoldKey: _scaffoldKey,
              onSeeAllToddler: () {
                setState(() {
                  _currentTab = 3;
                });
              },
              onSeeAllMeasurement: () {
                setState(() {
                  _currentTab = 1;
                });
              },
              onSeeAllImmunization: () {
                setState(() {
                  _currentTab = 2;
                });
              },
            ),
            const CadreMeasurement(),
            const CadreImmunization(),
            const CadreToddler(),
          ],
        ),
      ),
    );
  }
}
