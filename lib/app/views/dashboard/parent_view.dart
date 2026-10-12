import 'dart:io' show exit;

import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/views/dashboard/widgets/dashboard_end_drawer.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_bottom_nav.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_growth.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_home.dart';
import 'package:e_penting/app/views/dashboard/widgets/parent/parent_immunization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentView extends StatefulWidget {
  const new({super.key});

  @override
  State<ParentView> createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTab = 0;
  final _scrollController = ScrollController();

  void _onTabChange(int index) {
    setState(() {
      _currentTab = index;
    });

    if (!_scrollController.hasClients) return;

    final currentScroll = _scrollController.position.pixels;
    final minScroll = _scrollController.position.minScrollExtent;

    if (currentScroll != minScroll) {
      _scrollController.jumpTo(minScroll);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;

    if (authState.children.isNotEmpty) {
      context.read<SelectedChildCubit>().selectChild(authState.children.first);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectedChildCubit, Anak?>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, selectedChild) {
        final toddlerCubit = context.read<ToddlerCubit>();
        final immunizationCubit = context.read<ImmunizationCubit>();
        final measurementCubit = context.read<MeasurementCubit>();

        toddlerCubit.refetchToodlerLatestNik(nik: selectedChild?.nik);
        immunizationCubit.refetchImmunizationHistoryNik(
          nik: selectedChild?.nik,
        );
        measurementCubit.refetchAllParentData(nik: selectedChild?.nik);
      },
      child: PopScope(
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
          endDrawer: const DashboardEndDrawer(),
          bottomNavigationBar: ParentBottomNav(
            currentTab: _currentTab,
            onTabChange: _onTabChange,
          ),
          body: IndexedStack(
            index: _currentTab,
            children: [
              ParentHome(
                isActive: _currentTab == 0,
                scaffoldKey: _scaffoldKey,
                onSeeMeasurementHistory: () {
                  _onTabChange(1);
                },
                onSeeImmunizationHistory: () {
                  _onTabChange(2);
                },
              ),
              ParentImmunization(isActive: _currentTab == 1),
              ParentGrowth(isActive: _currentTab == 2),
            ],
          ),
        ),
      ),
    );
  }
}
