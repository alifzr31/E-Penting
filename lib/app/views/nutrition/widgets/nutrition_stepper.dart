import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class NutritionStepper extends StatelessWidget {
  const new({required this.stepLabels, required this.currentStep, super.key});

  final List<String> stepLabels;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: currentStep,
      padding: .zero,
      internalPadding: 0,
      disableScroll: true,
      enableStepTapping: false,
      showLoadingAnimation: false,
      defaultStepBorderType: .normal,
      lineStyle: LineStyle(
        lineType: .normal,
        defaultLineColor: Colors.grey.shade300,
        activeLineColor: AppColors.blueColor,
        finishedLineColor: AppColors.blueColor,
        lineThickness: 2,
      ),
      stepRadius: 20,
      maxTitleLines: 2,
      activeStepBorderColor: AppColors.blueColor,
      finishedStepBackgroundColor: AppColors.blueColor,
      steps: List.generate(stepLabels.length, (index) {
        final isCompleted = currentStep > index;
        final isActive = currentStep == index;

        return EasyStep(
          customStep: Center(
            child: Text(
              (index + 1).toString(),
              textAlign: .center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive || isCompleted ? .w500 : .w400,
                color: isActive
                    ? AppColors.blueColor
                    : isCompleted
                    ? Colors.white
                    : Colors.grey.shade400,
              ),
            ),
          ),
          customTitle: Text(
            stepLabels[index],
            textAlign: .center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive || isCompleted ? .w500 : .w400,
              color: isActive || isCompleted
                  ? AppColors.blueColor
                  : Colors.grey.shade400,
            ),
          ),
        );
      }),
    );
  }
}
