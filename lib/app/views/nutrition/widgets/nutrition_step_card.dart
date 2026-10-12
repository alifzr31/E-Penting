import 'package:e_penting/app/cubits/nutrition/nutrition_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/views/nutrition/widgets/nutrition_result_dialog.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class NutritionStepCard extends StatelessWidget {
  const NutritionStepCard({
    required this.title,
    required this.description,
    required this.content,
    this.onNext,
    this.onBack,
    this.isFirstStep = false,
    this.isLastStep = false,
    this.onRecheck,
    super.key,
  });

  final String title;
  final String description;
  final Widget content;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback? onRecheck;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NutritionCubit, NutritionState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case .loading:
            context.loaderOverlay.show();
          case .success:
            context.loaderOverlay.hide();
            nutritionResultDialog(
              context,
              classification: state.classification,
              weight: state.weight,
              nutrition: state.nutrition,
              onRecheck: onRecheck,
            );
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Cek Status Gizi Anak Gagal',
              description: state.errorMessage,
            );
          default:
        }
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        clipBehavior: .antiAlias,
        shape: RoundedRectangleBorder(borderRadius: .circular(10)),
        child: Padding(
          padding: const .all(16),
          child: Column(
            children: [
              Text(
                title,
                textAlign: .center,
                style: const TextStyle(fontSize: 16, fontWeight: .w600),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: .center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              content,
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: BaseButtonIcon(
                      bgColor: AppColors.blueColor,
                      fgColor: Colors.white,
                      icon: isFirstStep
                          ? RemixIcon.closeLine
                          : RemixIcon.arrowLeftLine,
                      label: isFirstStep ? 'Tutup' : 'Kembali',
                      onPressed: onBack,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: BaseButtonIcon(
                        bgColor: AppColors.blueColor,
                        fgColor: Colors.white,
                        icon: isLastStep
                            ? RemixIcon.checkLine
                            : RemixIcon.arrowRightLine,
                        label: isLastStep ? 'Selesai' : 'Selanjutnya',
                        onPressed: onNext,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
