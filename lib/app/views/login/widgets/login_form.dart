import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/aktivasi_akun/aktivasiakun_page.dart';
import 'package:epenting/app/views/dashboard/dashboard_page.dart';
import 'package:epenting/app/views/status_gizi/statusgizi_page.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.currentTab,
    required this.formKey,
    required this.userController,
    required this.passwordController,
    required this.obscurePass,
    required this.onPressedVisiblePassword,
    super.key,
  });

  final int currentTab;
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final bool obscurePass;
  final void Function()? onPressedVisiblePassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseFormField(
            hint: currentTab == 0 ? 'Username' : 'NIK',
            controller: userController,
            maxLength: currentTab == 0 ? null : 16,
            keyboardType: currentTab == 0 ? null : TextInputType.number,
            prefixIcon: Icon(
              currentTab == 0 ? MingCute.user_3_line : MingCute.IDcard_line,
              size: 18.sp,
              color: AppColors.blueColor,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return currentTab == 0
                    ? 'Mohon isi username anda'
                    : 'Mohon isi NIK anda';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormField(
            hint: 'Password',
            controller: passwordController,
            obscureText: obscurePass,
            prefixIcon: Icon(
              MingCute.key_2_line,
              size: 18.sp,
              color: AppColors.blueColor,
            ),
            suffixIcon: BaseIconButton(
              icon: obscurePass ? MingCute.eye_fill : MingCute.eye_close_line,
              size: 18.sp,
              color: AppColors.blueColor,
              onPressed: onPressedVisiblePassword,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon isi password anda';
              }

              return null;
            },
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              if (currentTab == 1)
                Expanded(
                  child: SizedBox(
                    height: 30.h,
                    child: BaseOutlineButtonIcon(
                      borderColor: AppColors.blueColor,
                      fgColor: AppColors.blueColor,
                      label: 'Aktivasi Akun',
                      icon: MingCute.safety_certificate_line,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AktivasiAkunPage.routeName,
                        );
                      },
                    ),
                  ),
                ),
              if (currentTab == 1) SizedBox(width: 10.w),
              Expanded(
                child: BlocListener<AuthCubit, AuthState>(
                  listenWhen:
                      (previous, current) =>
                          previous.loginStatus != current.loginStatus,
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.loading) {
                      context.loaderOverlay.show();
                    }

                    if (state.loginStatus == LoginStatus.success) {
                      context.loaderOverlay.hide();
                      Navigator.pushReplacementNamed(
                        context,
                        DashboardPage.routeName,
                      );
                    }

                    if (state.loginStatus == LoginStatus.error) {
                      context.loaderOverlay.hide();
                      showCustomToast(
                        context,
                        type: ToastificationType.error,
                        title: 'Masuk Gagal',
                        description: state.loginError,
                      );
                    }
                  },
                  child: SizedBox(
                    height: 30.h,
                    child: BaseButtonIcon(
                      bgColor: AppColors.orangeColor,
                      fgColor: Colors.white,
                      label: 'Masuk',
                      icon: MingCute.entrance_line,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().login(
                            currentTab: currentTab,
                            username: userController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: Colors.grey.shade400),
              ),
              SizedBox(width: 4.w),
              Text(
                'atau',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Container(height: 1, color: Colors.grey.shade400),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 30.h,
            width: double.infinity,
            child: BaseOutlineButtonIcon(
              icon: MingCute.dashboard_line,
              borderColor: AppColors.orangeColor,
              label: 'Cek Status Gizi Anak',
              fgColor: AppColors.orangeColor,
              onPressed: () {
                Navigator.pushNamed(context, StatusGiziPage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
