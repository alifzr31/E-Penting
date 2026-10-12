import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';

class BaseLoadScroll extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const .only(top: 10),
      child: Center(
        child: Card(
          color: Colors.white,
          clipBehavior: .antiAlias,
          elevation: 1,
          shape: const CircleBorder(),
          child: Center(
            child: Padding(
              padding: const .all(4),
              child: Lottie.asset(
                '${AppStrings.assetsLotties}/loader.json',
                width: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
