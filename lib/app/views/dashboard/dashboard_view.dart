import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/views/dashboard/cadre_page.dart';
import 'package:e_penting/app/views/dashboard/parent_page.dart';
import 'package:e_penting/app/widgets/base_handlestate.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous.profileStatus != current.profileStatus;
      },
      listener: (context, state) {
        if (state.profileStatus == .error) {
          showCustomToast(
            context,
            type: ToastificationType.error,
            title: 'Memuat Profil Gagal',
            description: state.profileErrorMessage,
          );
        }
      },
      buildWhen: (previous, current) {
        return previous.profileStatus != current.profileStatus ||
            previous.profile?.level != current.profile?.level;
      },
      builder: (context, state) {
        switch (state.profileStatus) {
          case .error:
            return Scaffold(
              body: Padding(
                padding: const .all(16),
                child: BaseHandleState(
                  handleType: .error,
                  errorMessage: state.profileErrorMessage ?? '',
                  onRefetch: () {
                    context.read<AuthCubit>().refetchProfile();
                  },
                ),
              ),
            );
          case .success:
            switch (state.profile?.level) {
              case 'orangtua':
                return const ParentPage();
              case 'kader_posyandu':
                return const CadrePage();
              default:
                return const SizedBox.shrink();
            }
          default:
            return Scaffold(
              body: Center(
                child: Lottie.asset(
                  '${AppStrings.assetsLotties}/loader.json',
                  width: 120,
                ),
              ),
            );
        }
      },
    );
  }
}
