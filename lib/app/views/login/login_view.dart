import 'dart:io' show exit;

import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/login/widgets/login_form.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  int _currentTab = 0;

  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePass = true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      _userController.text = 'PosyanduKarangPamulangMelati1';
      _passwordController.text = '123456';
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        await SystemNavigator.pop();
        exit(0);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.deviceHeight,
            width: context.deviceWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 186,
                  width: .infinity,
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        width: .infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: .only(
                            bottomLeft: .circular(30),
                            bottomRight: .circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const .all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: .circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                '${AppStrings.assetsImages}/logo2.svg',
                                width: 96,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'E-Penting',
                  textAlign: .center,
                  style: TextStyle(fontSize: 22, fontWeight: .w600),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      children: [
                        Padding(
                          padding: const .symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: List.generate(2, (index) {
                              return Container(
                                width: 150,
                                margin: .only(right: index == 0 ? 32 : 0),
                                child: InkWell(
                                  borderRadius: .circular(10),
                                  onTap: () {
                                    if (_currentTab != index) {
                                      setState(() {
                                        _currentTab = index;
                                        _obscurePass = true;
                                      });

                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                            FocusScope.of(context).unfocus();
                                            _formKey.currentState?.reset();
                                            if (kDebugMode) {
                                              _userController.text =
                                                  _currentTab == 0
                                                  ? 'PosyanduKarangPamulangMelati1'
                                                  : '3273054401910005';
                                            } else {
                                              _userController.clear();
                                              _passwordController.clear();
                                            }
                                          });
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCubic,
                                    height: 180,
                                    padding: const .symmetric(
                                      vertical: 20,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _currentTab == index
                                          ? const Color(0xFFCFE5F7)
                                          : null,
                                      borderRadius: .circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: AnimatedOpacity(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOutCubic,
                                            opacity: _currentTab == index
                                                ? 1
                                                : 0.4,
                                            child: SvgPicture.asset(
                                              index == 0
                                                  ? '${AppStrings.assetsImages}/kader.svg'
                                                  : '${AppStrings.assetsImages}/keluarga.svg',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          index == 0
                                              ? 'Kader Posyandu'
                                              : 'Orang Tua Anak',
                                          textAlign: .center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: .w600,
                                            color: _currentTab == index
                                                ? AppColors.blueColor
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 32),
                        LoginForm(
                          currentTab: _currentTab,
                          formKey: _formKey,
                          userController: _userController,
                          passwordController: _passwordController,
                          obscurePass: _obscurePass,
                          onPressedObscurePass: () {
                            setState(() {
                              _obscurePass = !_obscurePass;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
