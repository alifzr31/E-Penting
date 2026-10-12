import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/show_basemonthpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CadreMeasurementHeaderSection extends StatelessWidget {
  const new({
    required this.keywordController,
    required this.keyword,
    required this.onSearchMeasurement,
    required this.selectedMonthYear,
    required this.onSelectedMonthYear,
    required this.onRemoveSelectedMonthYear,
    super.key,
  });

  final TextEditingController keywordController;
  final String? keyword;
  final void Function(String? value) onSearchMeasurement;
  final DateTime? selectedMonthYear;
  final void Function(DateTime monthYear) onSelectedMonthYear;
  final VoidCallback? onRemoveSelectedMonthYear;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .infinity,
      child: Material(
        elevation: 1,
        color: Colors.white,
        clipBehavior: .antiAlias,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const .all(16),
            child: Column(
              children: [
                const Align(
                  alignment: .centerLeft,
                  child: Text(
                    'Kelola Data\nPengukuran',
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                ),
                const SizedBox(height: 10),
                BaseFormField(
                  hint: 'Cari berdasarkan nama balita',
                  controller: keywordController,
                  prefixIcon: const Icon(RemixIcon.search2Line, size: 18),
                  onChanged: onSearchMeasurement,
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    if (keyword == null || (keyword?.isEmpty ?? false)) ...[
                      SizedBox(
                        height: 38,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            foregroundColor: const WidgetStatePropertyAll(
                              AppColors.blueColor,
                            ),
                            iconColor: const WidgetStatePropertyAll(
                              AppColors.blueColor,
                            ),
                            overlayColor: WidgetStatePropertyAll(
                              AppColors.blueColor.withValues(alpha: 0.1),
                            ),
                            side: const WidgetStatePropertyAll(
                              BorderSide(width: 1, color: AppColors.blueColor),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: .circular(8),
                              ),
                            ),
                            alignment: .center,
                            padding: const WidgetStatePropertyAll(
                              .symmetric(horizontal: 10),
                            ),
                            minimumSize: const WidgetStatePropertyAll(.zero),
                          ),
                          onPressed: () async {
                            final monthYear = await showBaseMonthPicker(
                              context,
                              initialDate: selectedMonthYear,
                              lastDate: .now(),
                            );

                            if (!context.mounted || monthYear == null) {
                              return;
                            }

                            onSelectedMonthYear(monthYear);
                          },
                          child: selectedMonthYear == null
                              ? const Padding(
                                  padding: .symmetric(horizontal: 10),
                                  child: Icon(
                                    RemixIcon.calendar2Line,
                                    size: 20,
                                    color: AppColors.blueColor,
                                  ),
                                )
                              : Text(
                                  selectedMonthYear?.monthYear() ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: .w500,
                                    color: AppColors.blueColor,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: BaseOutlineButtonIcon(
                        width: .infinity,
                        icon: RemixIcon.addLine,
                        label: 'Pengukuran Baru',
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            RouteName.createMeasurement,
                          );

                          if (!context.mounted || result == null) {
                            return;
                          }

                          final isSuccess = result as bool;

                          if (isSuccess) {
                            context
                                .read<MeasurementCubit>()
                                .refetchMeasurements(
                                  keyword: keyword,
                                  month: selectedMonthYear?.month,
                                  year: selectedMonthYear?.year,
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                if (selectedMonthYear != null) ...[
                  const SizedBox(height: 4),
                  Align(
                    alignment: .centerLeft,
                    child: CupertinoButton(
                      alignment: .center,
                      minimumSize: .zero,
                      padding: const .all(2),
                      onPressed: onRemoveSelectedMonthYear,
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(
                            RemixIcon.calendarCloseLine,
                            size: 16,
                            color: Colors.red.shade600,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              'Hapus Filter Bulan',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w500,
                                fontFamily: 'Poppins',
                                color: Colors.red.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
