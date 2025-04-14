import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditImunisasiBalitaForm extends StatelessWidget {
  const EditImunisasiBalitaForm({
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
        BaseFormGroupField(
          label: 'Nama Balita',
          hint: 'Masukkan nama balita',
          mandatory: true,
          controller: namaBalitaController,
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Mohon masukkan nama balita';
            }

            return null;
          },
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
