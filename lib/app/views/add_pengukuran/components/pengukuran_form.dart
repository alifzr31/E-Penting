import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

class PengukuranForm extends StatelessWidget {
  const PengukuranForm({
    required this.pemberianVitAController,
    required this.onSelectedPemberianVitA,
    required this.selectedPemberianVitA,
    required this.jumlahPemberianController,
    required this.pittingEdemaController,
    required this.onSelectedPittingEdema,
    required this.selectedPittingEdema,
    required this.derajatController,
    required this.onSelectedDerajat,
    required this.showDerajatValidate,
    required this.kelasIbuBalitaController,
    required this.onSelectedKelasIbuBalita,
    super.key,
  });

  final GroupButtonController pemberianVitAController;
  final dynamic Function(String, int, bool)? onSelectedPemberianVitA;
  final String? selectedPemberianVitA;
  final TextEditingController jumlahPemberianController;
  final GroupButtonController pittingEdemaController;
  final dynamic Function(String, int, bool)? onSelectedPittingEdema;
  final String selectedPittingEdema;
  final GroupButtonController derajatController;
  final dynamic Function(int, int, bool)? onSelectedDerajat;
  final bool showDerajatValidate;
  final GroupButtonController kelasIbuBalitaController;
  final dynamic Function(String, int, bool)? onSelectedKelasIbuBalita;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Pemberian Vitamin A',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        GroupButton(
          controller: pemberianVitAController,
          isRadio: true,
          buttons: ['ya', 'tidak'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12.r,
                  width: 12.r,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12.r,
                    width: 12.r,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? AppColors.blueColor
                              : Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Ya' : 'Tidak',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelectedPemberianVitA,
        ),
        if (selectedPemberianVitA == 'ya') ...{
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Jumlah yang Diberikan',
            hint: 'Masukkan jumlah yang diberikan',
            mandatory: true,
            controller: jumlahPemberianController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan jumlah yang diberikan';
              }

              return null;
            },
          ),
        },
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Pitting Edema',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        GroupButton(
          controller: pittingEdemaController,
          isRadio: true,
          buttons: ['ya', 'tidak'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12.r,
                  width: 12.r,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12.r,
                    width: 12.r,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? AppColors.blueColor
                              : Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Ya' : 'Tidak',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelectedPittingEdema,
        ),
        if (selectedPittingEdema == 'ya') ...{
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Suhu Derajat',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          GroupButton(
            controller: derajatController,
            isRadio: true,
            buttons: [1, 2, 3],
            buttonIndexedBuilder: (selected, index, context) {
              return Row(
                children: [
                  Container(
                    height: 12.r,
                    width: 12.r,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 12.r,
                      width: 12.r,
                      decoration: BoxDecoration(
                        color:
                            selected
                                ? AppColors.blueColor
                                : Colors.indigo.shade100,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      index == 0
                          ? 'Suhu +1 Derajat'
                          : index == 1
                          ? 'Suhu +2 Derajat'
                          : 'Suhu +3 Derajat',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
            onSelected: onSelectedDerajat,
          ),
          if (showDerajatValidate) ...{
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih suhu derajat',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          },
        },
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Kelas Ibu Balita',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        GroupButton(
          controller: kelasIbuBalitaController,
          isRadio: true,
          buttons: ['ya', 'tidak'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12.r,
                  width: 12.r,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12.r,
                    width: 12.r,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? AppColors.blueColor
                              : Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Ya' : 'Tidak',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelectedKelasIbuBalita,
        ),
      ],
    );
  }
}
