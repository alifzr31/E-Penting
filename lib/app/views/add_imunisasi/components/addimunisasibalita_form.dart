import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddImunisasiBalitaForm extends StatelessWidget {
  const AddImunisasiBalitaForm({
    required this.namaBalitaController,
    required this.onSelectedNamaBalita,
    required this.nikBalitaController,
    required this.tglLahirController,
    super.key,
  });

  final TextEditingController namaBalitaController;
  final void Function(Balita)? onSelectedNamaBalita;
  final TextEditingController nikBalitaController;
  final TextEditingController tglLahirController;

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
      ],
    );
  }
}
