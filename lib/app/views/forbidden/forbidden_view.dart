import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ForbiddenView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous.logoutStatus != current.logoutStatus;
      },
      listener: (context, state) {
        switch (state.logoutStatus) {
          case .loading:
            context.loaderOverlay.show();
            break;
          case .success:
            context.loaderOverlay.hide();

            final name = state.profile?.level == 'kader_posyandu'
                ? 'Posyandu ${state.profile?.name?.capitalize()}'
                : state.profile?.name;

            showCustomToast(
              context,
              type: .success,
              title: 'Keluar Berhasil',
              description: 'Sampai jumpa lagi $name!',
            );
            context.read<AuthCubit>().resetState();
            Navigator.pushReplacementNamed(context, RouteName.login);
            break;
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Keluar Gagal',
              description: state.logoutErrorMessage,
            );
            break;
          default:
            return;
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const .all(16),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Lottie.asset(
                    '${AppStrings.assetsLotties}/forbidden.json',
                    width: 240,
                    frameRate: const FrameRate(144),
                  ),
                  const Text(
                    'Akses Ditolak',
                    textAlign: .center,
                    style: TextStyle(fontSize: 18, fontWeight: .w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Akun anda tidak memiliki izin untuk mengakses laman ini.',
                    textAlign: .center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  BaseOutlineButtonIcon(
                    icon: RemixIcon.closeCircleLine,
                    label: 'Tutup',
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
