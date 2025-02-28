import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/login/login_page.dart';
import 'package:epenting/app/views/onboard/components/onboard_model.dart';
import 'package:epenting/app/views/onboard/widgets/onboard_item.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  static const String routeName = '/onBoard';

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int currentPage = 0;
  final _pageController = PageController();
  final _onBoardModelItems = [
    OnboardModel(
      image: '${AppStrings.assetsImages}/welcome.svg',
      title: 'Selamat Datang di E-Penting',
      description:
          'Aplikasi E-Penting (Pendataan Stunting) merupakan aplikasi yang dibangun oleh Pemerintah Kota Bandung yang diharapkan dapat membantu menurunkan angka stunting pada bayi berusia dibawah lima tahun.',
    ),
    OnboardModel(
      image: '${AppStrings.assetsImages}/baby.svg',
      title: 'Rekam Jejak Gizi Balita',
      description:
          'Apabila Anda memiliki balita, Anda dapat melihat rekam jejak pendataan gizi bayi anak Anda di aplikasi ini.',
    ),
  ];

  void _onPressedNextFinish() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    if (currentPage == 0) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      await sharedPreferences.setBool('opened_onboard', true);
      await sharedPreferences.reload();

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginPage.routeName,
          (route) => false,
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
          color: currentPage == 0 ? Colors.blue.shade500 : Colors.teal.shade500,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: _onBoardModelItems.length,
                  itemBuilder: (context, index) {
                    final item = _onBoardModelItems[index];

                    return OnboardItem(
                      image: item.image,
                      title: item.title,
                      description: item.description,
                    );
                  },
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color:
                    currentPage == 0
                        ? Colors.blue.shade600
                        : Colors.teal.shade600,
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: Row(
                        children: List.generate(_onBoardModelItems.length, (
                          index,
                        ) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                            height: currentPage == index ? 8 : 6,
                            width: currentPage == index ? 8 : 6,
                            margin: EdgeInsets.only(
                              right:
                                  index == (_onBoardModelItems.length - 1)
                                      ? 0
                                      : 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  currentPage == index
                                      ? Colors.white
                                      : Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOutCubic,
                      switchOutCurve: Curves.easeInOutCubic,
                      transitionBuilder:
                          (widget, animation) =>
                              ScaleTransition(scale: animation, child: widget),
                      child: BaseIconButton(
                        key:
                            currentPage == 0
                                ? ValueKey('arrow')
                                : ValueKey('check'),
                        icon:
                            currentPage == 0
                                ? Icons.chevron_right
                                : Icons.check,
                        size: 20.sp,
                        color: Colors.white,
                        onPressed: _onPressedNextFinish,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
