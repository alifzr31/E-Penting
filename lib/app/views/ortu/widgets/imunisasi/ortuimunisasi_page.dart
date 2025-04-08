import 'package:epenting/app/models/vaccine.dart';
import 'package:epenting/app/views/ortu/widgets/imunisasi/ortuimunisasi_history.dart';
import 'package:epenting/app/views/ortu/widgets/imunisasi/ortuimunisasi_vaccine.dart';
import 'package:epenting/app/views/ortu/widgets/ortuanak_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuImunisasiPage extends StatelessWidget {
  const OrtuImunisasiPage({required this.vaccines, super.key});

  final List<Vaccine> vaccines;

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
        OrtuimunisasiVaccine(vaccines: vaccines),
        SizedBox(height: 10.h),
        const OrtuImunisasiHistory(),
      ],
    );
  }
}
