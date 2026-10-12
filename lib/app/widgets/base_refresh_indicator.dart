import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';

class BaseRefreshIndicator extends StatelessWidget {
  const new({
    required this.onRefresh,
    required this.child,
    this.displacement = 40,
    super.key,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double displacement;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      elevation: 1,
      backgroundColor: Colors.white,
      color: AppColors.orangeColor,
      displacement: displacement,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
