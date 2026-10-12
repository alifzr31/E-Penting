import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/material.dart';

class CadreToddlerFilterSection extends StatelessWidget {
  const new({
    required this.rangeMonthAge,
    required this.selectedRangeMonthAge,
    required this.onSelectedRangeMonthAge,
    super.key,
  });

  final List<String> rangeMonthAge;
  final String? selectedRangeMonthAge;
  final void Function(String rangeMonthAge) onSelectedRangeMonthAge;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      padding: const .only(top: 10, left: 16, right: 16, bottom: 6),
      child: Row(
        children: List.generate(rangeMonthAge.length, (index) {
          final rangeMonth = rangeMonthAge[index];
          final label = rangeMonth == 'all'
              ? 'Semua Usia'
              : '$rangeMonth Bulan';

          return Row(
            children: [
              Card(
                elevation: 1,
                color: selectedRangeMonthAge == rangeMonth
                    ? AppColors.blueColor
                    : Colors.white,
                clipBehavior: .antiAlias,
                shape: const StadiumBorder(),
                margin: const .symmetric(vertical: 2),
                child: InkWell(
                  onTap: selectedRangeMonthAge == rangeMonth
                      ? null
                      : () {
                          onSelectedRangeMonthAge(rangeMonth);
                        },
                  child: Padding(
                    padding: const .symmetric(vertical: 6, horizontal: 10),
                    child: Center(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: selectedRangeMonthAge == rangeMonth
                              ? .w500
                              : .w400,
                          color: selectedRangeMonthAge == rangeMonth
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (index != rangeMonthAge.length) ...[const SizedBox(width: 8)],
            ],
          );
        }),
      ),
    );
  }
}
