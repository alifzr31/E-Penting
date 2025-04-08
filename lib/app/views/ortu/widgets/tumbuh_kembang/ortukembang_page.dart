import 'package:epenting/app/views/ortu/widgets/ortuanak_card.dart';
import 'package:epenting/app/views/ortu/widgets/tumbuh_kembang/ortukembang_chart.dart';
import 'package:epenting/app/views/ortu/widgets/tumbuh_kembang/ortukembang_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuKembangPage extends StatelessWidget {
  const OrtuKembangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 80),
      children: [
        const SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: OrtuAnakCard(),
          ),
        ),
        SizedBox(height: 10.h),
        const OrtuKembangChart(),
        SizedBox(height: 10.h),
        const OrtuKembangHistory(),
      ],
    );
  }
}
