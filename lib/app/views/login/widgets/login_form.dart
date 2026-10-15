import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/login/login_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/base_iconbutton.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:string_validator/string_validator.dart';

class LoginForm extends StatelessWidget {
  const new({
    required this.currentTab,
    required this.formKey,
    required this.userController,
    required this.passwordController,
    required this.obscurePass,
    required this.onPressedObscurePass,
    super.key,
  });

  final int currentTab;
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final bool obscurePass;
  final void Function()? onPressedObscurePass;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case .loading:
            context.loaderOverlay.show();
          case .success:
            final name = state.responseData?['data']['name'];
            final level = state.responseData?['data']['level'];
            final forbiddenLevel =
                level != 'kader_posyandu' && level != 'orangtua';
            final accessToken = state.responseData?['token'];

            context.loaderOverlay.hide();
            context.read<AuthCubit>().setToken(accessToken);
            showCustomToast(
              context,
              type: .success,
              title: 'Masuk Berhasil',
              description: 'Selamat datang $name!',
            );
            Navigator.pushReplacementNamed(
              context,
              forbiddenLevel ? RouteName.forbidden : RouteName.dashboard,
            );
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Masuk Gagal',
              description: state.errorMessage,
            );
          default:
            break;
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          children: [
            BaseFormField(
              hint: currentTab == 0 ? 'Username' : 'NIK',
              controller: userController,
              maxLength: currentTab == 0 ? null : 16,
              textInputAction: .next,
              keyboardType: currentTab == 0 ? null : .number,
              inputFormatters: currentTab == 0
                  ? null
                  : [FilteringTextInputFormatter.digitsOnly],
              prefixIcon: Icon(
                currentTab == 0 ? RemixIcon.userLine : RemixIcon.idCardLine,
                size: 18,
                color: AppColors.blueColor,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return currentTab == 0
                      ? 'Silahkan masukkan username anda'
                      : 'Silahkan masukkan NIK anda';
                } else {
                  if (currentTab == 1 && !value.isInt) {
                    return 'NIK yang anda masukkan tidak valid';
                  }
                }

                return null;
              },
            ),
            const SizedBox(height: 10),
            BaseFormField(
              hint: 'Password',
              controller: passwordController,
              obscureText: obscurePass,
              textInputAction: .done,
              prefixIcon: const Icon(
                RemixIcon.lock2Line,
                size: 18,
                color: AppColors.blueColor,
              ),
              suffixIcon: BaseIconButton(
                icon: obscurePass ? RemixIcon.eyeFill : RemixIcon.eyeCloseLine,
                size: 18,
                onPressed: onPressedObscurePass,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Silahkan masukkan password anda';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (currentTab == 1) ...[
                  Expanded(
                    child: BaseOutlineButtonIcon(
                      borderColor: AppColors.blueColor,
                      fgColor: AppColors.blueColor,
                      icon: RemixIcon.shieldCheckLine,
                      label: 'Aktivasi Akun',
                      onPressed: () {
                        showCustomToast(
                          context,
                          type: .info,
                          title: 'Informasi',
                          description: 'Mohon maaf saat ini fitur aktivasi akun masih dalam tahap pengembangan.',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: BaseButtonIcon(
                    icon: RemixIcon.doorOpenLine,
                    label: 'Masuk',
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<LoginCubit>().login(
                          username: userController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const .symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(height: 1, color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const .symmetric(horizontal: 10),
                    child: Text(
                      'atau',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(height: 1, color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
            BaseOutlineButtonIcon(
              width: .infinity,
              icon: RemixIcon.dashboard2Line,
              label: 'Cek Status Gizi Anak',
              onPressed: () {
                Navigator.pushNamed(context, RouteName.nutrition);
              },
            ),
          ],
        ),
      ),
    );
  }
}
