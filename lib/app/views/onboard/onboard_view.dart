import 'dart:io' show exit;

import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/views/onboard/widgets/onboard_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show SystemNavigator;

class OnboardView extends StatefulWidget {
  const new({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  int _currentPage = 0;
  final _pageController = PageController();
  final _onboardItems = [
    {
      'image': 'welcome.svg',
      'title': 'Selamat Datang di E-Penting',
      'description': 'Aplikasi E-Penting (Pendataan Stunting) merupakan aplikasi yang dibangun oleh Pemerintah Kota Bandung yang diharapkan dapat membantu menurunkan angka stunting pada bayi berusia dibawah lima tahun.',
    },
    {
      'image': 'baby.svg',
      'title': 'Rekam Jejak Gizi Balita',
      'description': 'Apabila Anda memiliki balita, Anda dapat melihat rekam jejak pendataan gizi bayi anak Anda di aplikasi ini.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
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
        backgroundColor: Colors.transparent,
        body: AnimatedContainer(
          height: context.deviceHeight,
          width: context.deviceWidth,
          color: _currentPage == 0
              ? Colors.blue.shade500
              : Colors.teal.shade500,
          clipBehavior: .antiAlias,
          curve: Curves.easeInOutCubic,
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _onboardItems.length,
                  itemBuilder: (context, index) {
                    final onboard = _onboardItems[index];

                    return SafeArea(
                      bottom: false,
                      child: Center(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            mainAxisAlignment: .center,
                            children: [
                              SizedBox(
                                height: 180,
                                width: .infinity,
                                child: SvgPicture.asset(
                                  '${AppStrings.assetsImages}/${onboard['image']}',
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                onboard['title'] ?? '',
                                textAlign: .center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                onboard['description'] ?? '',
                                textAlign: .center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              OnboardFooter(
                pageController: _pageController,
                currentPage: _currentPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
