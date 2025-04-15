import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_forminfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:group_button/group_button.dart';

class AddPengukuranBalitaForm extends StatelessWidget {
  const AddPengukuranBalitaForm({
    required this.namaBalitaController,
    required this.onSelectedNamaBalita,
    required this.nikBalitaController,
    required this.tglLahirController,
    required this.caraPengukuranController,
    required this.onSelectedCaraPengukuran,
    required this.selectedCaraPengukuran,
    required this.beratBadanController,
    required this.panjangBadanController,
    required this.lilaController,
    required this.lingkarKepalaController,
    super.key,
  });

  final TextEditingController namaBalitaController;
  final void Function(Balita)? onSelectedNamaBalita;
  final TextEditingController nikBalitaController;
  final TextEditingController tglLahirController;
  final GroupButtonController caraPengukuranController;
  final dynamic Function(String, int, bool)? onSelectedCaraPengukuran;
  final String? selectedCaraPengukuran;
  final TextEditingController beratBadanController;
  final TextEditingController panjangBadanController;
  final TextEditingController lilaController;
  final TextEditingController lingkarKepalaController;

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
                  text: 'Nama Balita',
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
        TypeAheadField<Balita>(
          controller: namaBalitaController,
          builder: (context, controller, focusNode) {
            return BaseFormField(
              hint: 'Masukkan nama balita',
              controller: controller,
              focusNode: focusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Mohon masukkan nama balita';
                }

                return null;
              },
            );
          },
          decorationBuilder: (context, child) {
            return Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(6.r),
              clipBehavior: Clip.antiAlias,
              child: child,
            );
          },
          hideWithKeyboard: false,
          constraints: BoxConstraints(maxHeight: 200.h),
          loadingBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sedang memuat...',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  CupertinoActivityIndicator(radius: 6.r),
                ],
              ),
            );
          },
          emptyBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                'Balita Tidak Ditemukan!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            );
          },
          itemBuilder: (context, value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                value.namaAnak ?? '',
                style: TextStyle(fontSize: 14.sp),
              ),
            );
          },
          onSelected: onSelectedNamaBalita,
          suggestionsCallback:
              (keyword) => context.read<BalitaCubit>().searchBalita(keyword),
        ),
        SizedBox(height: 10.h),
        BaseFormGroupField(
          label: 'NIK',
          hint: 'Pilih nama balita terlebih dahulu',
          mandatory: true,
          controller: nikBalitaController,
          readOnly: true,
          maxLength: 16,
          keyboardType: TextInputType.number,
          helperText: 'NIK balita otomatis terisi setelah memilih nama balita',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Mohon masukkan NIK balita dengan memilih nama balita';
            }

            return null;
          },
        ),
        SizedBox(height: 10.h),
        BaseFormGroupField(
          label: 'Tanggal Lahir',
          hint: 'Pilih nama balita terlebih dahulu',
          mandatory: true,
          controller: tglLahirController,
          readOnly: true,
          keyboardType: TextInputType.datetime,
          helperText:
              'Tanggal lahir otomatis terisi setelah memilih nama balita',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Mohon masukkan tanggal lahir dengan memilih nama balita';
            }

            return null;
          },
        ),
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'Cara Pengukuran',
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
          controller: caraPengukuranController,
          isRadio: true,
          buttons: ['berdiri', 'terlentang'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12.r,
                  width: 12.r,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.blueColor),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected ? AppColors.blueColor : Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Berdiri' : 'Terlentang',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelectedCaraPengukuran,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: BaseFormGroupField(
                label: 'Berat Badan',
                hint: 'Contoh: 3.5',
                mandatory: true,
                controller: beratBadanController,
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'kg',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan berat badan balita';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: BaseFormGroupField(
                label:
                    selectedCaraPengukuran == 'berdiri'
                        ? 'Tinggi Badan'
                        : 'Panjang Badan',
                hint: 'Contoh: 50',
                mandatory: true,
                controller: panjangBadanController,
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'cm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan ${selectedCaraPengukuran == 'berdiri' ? 'tinggi' : 'panjang'} badan balita';
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        BaseFormInfo(
          message: 'Gunakan titik (.) untuk koma',
          bgColor: Colors.teal.shade100,
          fgColor: Colors.teal.shade700,
        ),
        SizedBox(height: 4.h),
        BaseFormInfo(
          message:
              'Pastikan ${selectedCaraPengukuran == 'berdiri' ? 'tinggi' : 'panjang'} badan yang anda masukkan adalah angka hasil pengukuran yang belum dikoreksi dengan 0.7 cm',
          bgColor: Colors.deepOrange.shade100,
          fgColor: Colors.deepOrange.shade700,
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Lingkar Lengan Atas (LILA)',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: 'Lingkar Kepala',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: BaseFormField(
                hint: 'Contoh: 12.7',
                controller: lilaController,
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'cm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: BaseFormField(
                hint: 'Contoh: 20',
                controller: lingkarKepalaController,
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    'cm',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
