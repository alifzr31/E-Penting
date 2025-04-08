import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/views/ortu/widgets/home/ortuhome_header.dart';
import 'package:epenting/app/views/ortu/widgets/home/ortuhome_imunisasi.dart';
import 'package:epenting/app/views/ortu/widgets/home/ortuhome_panduan.dart';
import 'package:epenting/app/views/ortu/widgets/home/ortuhome_pengukuran.dart';
import 'package:epenting/app/views/ortu/widgets/ortuanak_card.dart';
import 'package:epenting/app/widgets/base_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuHomePage extends StatelessWidget {
  const OrtuHomePage({
    required this.ortuKey,
    required this.pengukuranHistory,
    required this.imunisasiHistory,
    required this.panduans,
    super.key,
  });

  final GlobalKey<ScaffoldState> ortuKey;
  final void Function()? pengukuranHistory;
  final void Function()? imunisasiHistory;
  final List<String> panduans;

  @override
  Widget build(BuildContext context) {
    return BaseRefresh(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) {
            context.read<AuthCubit>().fetchProfile().then((value) {
              if (context.mounted) {
                context.read<OrtuCubit>().selectAnak(
                  context.read<AuthCubit>().state.profile?.listAnak?.first,
                );
              }
            });
          }
        });
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          OrtuHomeHeader(ortuKey: ortuKey),
          SizedBox(height: 10.h),
          const OrtuAnakCard(),
          SizedBox(height: 10.h),
          OrtuHomePengukuran(pengukuranHistory: pengukuranHistory),
          SizedBox(height: 10.h),
          OrtuHomeImunisasi(imunisasiHistory: imunisasiHistory),
          SizedBox(height: 10.h),
          OrtuHomePanduan(panduans: panduans),
        ],
      ),
    );
  }
}
