import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/onboard/onboard_cubit.dart';
import 'package:e_penting/app/widgets/base_iconbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class OnboardFooter extends StatelessWidget {
  const new({
    required this.pageController,
    required this.currentPage,
    super.key,
  });

  final PageController pageController;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardCubit, OnboardState>(
      listenWhen: (previous, current) =>
          previous.pageStatus != current.pageStatus,
      listener: (context, state) {
        switch (state.pageStatus) {
          case PageStatus.first:
            pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
            );
          case PageStatus.last:
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.login,
              (route) => false,
            );
          default:
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        width: .infinity,
        padding: const .symmetric(vertical: 8, horizontal: 16),
        color: currentPage == 0 ? Colors.blue.shade600 : Colors.teal.shade600,
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                child: Row(
                  children: List.generate(2, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      height: currentPage == index ? 8 : 6,
                      width: currentPage == index ? 8 : 6,
                      margin: .only(right: index == 1 ? 0 : 6),
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.white
                            : Colors.grey.shade400,
                        shape: .circle,
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
                transitionBuilder: (widget, animation) {
                  return ScaleTransition(scale: animation, child: widget);
                },
                child: BaseIconButton(
                  key: currentPage == 0
                      ? const ValueKey('arrow')
                      : const ValueKey('check'),
                  icon: currentPage == 0
                      ? RemixIcon.arrowRightSLine
                      : RemixIcon.checkLine,
                  size: 22,
                  color: Colors.white,
                  onPressed: () {
                    context.read<OnboardCubit>().onNextFinishPage(currentPage);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
