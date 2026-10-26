import 'package:e_penting/app/cubits/activation/activation_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/base_textbutton.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class ActivationForm extends StatefulWidget {
  const new({super.key});

  @override
  State<ActivationForm> createState() => _ActivationFormState();
}

class _ActivationFormState extends State<ActivationForm> {
  final _formKey = GlobalKey<FormState>();
  final _parentNikController = TextEditingController();
  String? _familyCardNumber;
  String? _parentName;

  Future<Object?> _showActivateAlert() {
    return showAdaptiveDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          surfaceTintColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
          title: const Text('Informasi Aktivasi Akun'),
          content: Text(
            'Akun akan di aktifkan dengan NIK "${_parentNikController.text}" sebagai usernamenya dan passwordnya "123456". Aktifkan akun sekarang?',
          ),
          actions: [
            BaseTextButton(
              size: 14,
              text: 'Nanti Saja',
              color: AppColors.orangeColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 6),
            BaseTextButton(
              size: 14,
              text: 'Ya, Aktifkan Sekarang',
              color: AppColors.blueColor,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _parentNikController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ActivationCubit, ActivationState>(
          listenWhen: (previous, current) {
            return previous.checkStatus != current.checkStatus;
          },
          listener: (context, state) {
            switch (state.checkStatus) {
              case .loading:
                context.loaderOverlay.show();
                break;
              case .success:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .success,
                  title: 'Periksa NIK Berhasil',
                  description: state.checkResponseData?['message'],
                );

                _familyCardNumber =
                    state.checkResponseData?['data']['nomor_kk'];
                _parentName =
                    state.checkResponseData?['data']['nama_orang_tua'];
                setState(() {});
                break;
              case .error:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .error,
                  title: 'Periksa NIK Gagal',
                  description: state.checkErrorMessage,
                );
                break;
              default:
                return;
            }
          },
        ),
        BlocListener<ActivationCubit, ActivationState>(
          listenWhen: (previous, current) {
            return previous.activateStatus != current.activateStatus;
          },
          listener: (context, state) {
            switch (state.activateStatus) {
              case .loading:
                context.loaderOverlay.show();
                break;
              case .success:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .success,
                  title: 'Aktivasi Akun Berhasil',
                  description: 'Akun sudah berhasil di aktivasi, silahkan masuk ke menu orang tua.',
                );
                Navigator.pop(context);
                break;
              case .error:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .error,
                  title: 'Aktivasi Akun Gagal',
                  description: state.activateErrorMessage,
                );
                break;
              default:
                return;
            }
          },
        ),
      ],
      child: BlocBuilder<ActivationCubit, ActivationState>(
        buildWhen: (previous, current) {
          return previous.checkStatus != current.checkStatus;
        },
        builder: (context, state) {
          final isSuccess = state.checkStatus == .success;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                BaseFormField(
                  hint: 'Masukkan NIK Orang Tua',
                  controller: _parentNikController,
                  maxLength: 16,
                  keyboardType: .number,
                  readOnly: isSuccess,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan NIK Orang Tua';
                    }

                    return null;
                  },
                ),
                if (isSuccess) ...[
                  const SizedBox(height: 6),
                  Container(
                    width: .infinity,
                    padding: const .all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: .circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          'No. Kartu Keluarga :',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(_familyCardNumber ?? '-'),
                        const SizedBox(height: 4),
                        Text(
                          'Nama Orang Tua :',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(_parentName ?? '-'),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (isSuccess) ...[
                      Expanded(
                        child: BaseOutlineButtonIcon(
                          icon: RemixIcon.resetLeftLine,
                          label: 'Reset',
                          onPressed: () {
                            _parentNikController.clear();
                            _formKey.currentState?.reset();
                            context.read<ActivationCubit>().resetCheckState();
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: BaseButtonIcon(
                        bgColor: AppColors.blueColor,
                        fgColor: Colors.white,
                        icon: isSuccess
                            ? RemixIcon.shieldCheckLine
                            : RemixIcon.searchLine,
                        label: isSuccess ? 'Aktifkan Akun' : 'Periksa NIK',
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (isSuccess) {
                              final result = await _showActivateAlert();

                              if (result == null || !context.mounted) return;

                              final success = result as bool;

                              if (success) {
                                context
                                    .read<ActivationCubit>()
                                    .activateParentAccount(
                                      parentNik: _parentNikController.text,
                                    );
                              }
                            } else {
                              context.read<ActivationCubit>().checkParentNik(
                                parentNik: _parentNikController.text,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
