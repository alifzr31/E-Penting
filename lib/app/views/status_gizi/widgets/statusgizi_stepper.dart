import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusGiziStepper extends StatelessWidget {
  const StatusGiziStepper({
    required this.currentStep,
    required this.steps,
    this.onStepContinue,
    this.onStepCancel,
    super.key,
  });

  final int currentStep;
  final List<Step> steps;
  final void Function()? onStepContinue;
  final void Function()? onStepCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Stepper(
            currentStep: currentStep,
            stepIconBuilder: (stepIndex, stepState) {
              return CircleAvatar(
                backgroundColor:
                    currentStep >= stepIndex
                        ? AppColors.blueColor
                        : Colors.grey.shade500,
                child: Center(
                  child: Text(
                    (stepIndex + 1).toString(),
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            margin: EdgeInsets.zero,
            connectorThickness: 2,
            connectorColor: WidgetStateColor.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.blueColor;
              }

              return Colors.grey.shade400;
            }),
            stepIconMargin: const EdgeInsets.symmetric(vertical: 6),
            onStepContinue: onStepContinue,
            onStepCancel: onStepCancel,
            steps: steps,
            controlsBuilder: (context, details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0 && currentStep < 4)
                    BaseTextButton(
                      text: 'Kembali',
                      size: 12.sp,
                      color: AppColors.blueColor,
                      onPressed: details.onStepCancel,
                    ),
                  if (currentStep < 4)
                    SizedBox(
                      height: 30.h,
                      child: BaseButton(
                        bgColor: AppColors.blueColor,
                        fgColor: Colors.white,
                        label: 'Selanjutnya',
                        onPressed: details.onStepContinue,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
