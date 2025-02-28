import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/status_gizi/statusgizi_page.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
              currentTab == 0 ? Icons.person : Icons.contact_mail,
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
              Icons.password,
              size: 18.sp,
              color: AppColors.blueColor,
            ),
            suffixIcon: BaseIconButton(
              icon: obscurePass ? Icons.visibility : Icons.visibility_off,
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
                      icon: Icons.safety_check,
                      onPressed: () {},
                    ),
                  ),
                ),
              if (currentTab == 1) SizedBox(width: 10.w),
              Expanded(
                child: SizedBox(
                  height: 30.h,
                  child: BaseButtonIcon(
                    bgColor: AppColors.orangeColor,
                    fgColor: Colors.white,
                    label: 'Masuk',
                    icon: Icons.login,
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        context.loaderOverlay.show();

                        await Future.delayed(
                          const Duration(milliseconds: 1500),
                          () {
                            if (context.mounted) {
                              context.loaderOverlay.hide();
                            }
                          },
                        );
                      }
                    },
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
              icon: Icons.speed,
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
