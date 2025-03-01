import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<AuthCubit>().fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          switch (state.profileStatus) {
            case ProfileStatus.error:
              return Center(child: Text(state.profileError));
            case ProfileStatus.success:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.profile?.name ?? ''),
                    BlocListener<AuthCubit, AuthState>(
                      listenWhen:
                          (previous, current) =>
                              previous.logoutStatus != current.logoutStatus,
                      listener: (context, state) {
                        if (state.logoutStatus == LogoutStatus.loading) {
                          context.loaderOverlay.show();
                        }

                        if (state.logoutStatus == LogoutStatus.success) {
                          context.loaderOverlay.hide();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginPage.routeName,
                            (route) => false,
                          );
                          context.read<AuthCubit>().resetState();
                        }

                        if (state.logoutStatus == LogoutStatus.error) {
                          context.loaderOverlay.hide();
                          showCustomToast(
                            context,
                            type: ToastificationType.error,
                            title: 'Keluar Gagal',
                            description: state.logoutError,
                          );
                        }
                      },
                      child: BaseButton(
                        label: 'Logout',
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                        },
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
