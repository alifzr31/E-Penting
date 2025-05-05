import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_datepickerfield.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_forminfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

class EditBalitaForm extends StatelessWidget {
  const EditBalitaForm({
    required this.formKey,
    required this.nikAnakController,
    required this.noKkController,
    required this.namaBalitaController,
    required this.tglLahirController,
    required this.selectedTglLahir,
    required this.onConfirmTglLahir,
    required this.jenisKelaminController,
    required this.onSelectedJenisKelamin,
    required this.showJenisKelaminValidate,
    required this.anakKeController,
    required this.beratLahirController,
    required this.panjangLahirController,
    required this.lingkarKepalaController,
    required this.usiaKehamilanController,
    required this.kiaBayiKecilController,
    required this.onSelectedKiaBayiKecil,
    required this.showKiaBayiKecilValidate,
    required this.bukuKiaController,
    required this.onSelectedBukuKia,
    required this.showBukuKiaValidate,
    required this.imdController,
    required this.onSelectedImd,
    required this.showImdValidate,
    required this.nikOrtuController,
    required this.namaOrtuController,
    required this.noTelpOrtuController,
    required this.alamatController,
    required this.rtController,
    required this.rwController,
    required this.pendudukBandungController,
    required this.onSelectedPendudukBandung,
    required this.showPendudukBandungValidate,
    required this.kecamatanController,
    required this.kelurahanController,
    required this.puskesmasController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nikAnakController;
  final TextEditingController noKkController;
  final TextEditingController namaBalitaController;
  final TextEditingController tglLahirController;
  final DateTime? selectedTglLahir;
  final dynamic Function(DateTime)? onConfirmTglLahir;
  final GroupButtonController jenisKelaminController;
  final dynamic Function(String, int, bool)? onSelectedJenisKelamin;
  final bool showJenisKelaminValidate;
  final TextEditingController anakKeController;
  final TextEditingController beratLahirController;
  final TextEditingController panjangLahirController;
  final TextEditingController lingkarKepalaController;
  final TextEditingController usiaKehamilanController;
  final GroupButtonController kiaBayiKecilController;
  final dynamic Function(bool, int, bool)? onSelectedKiaBayiKecil;
  final bool showKiaBayiKecilValidate;
  final GroupButtonController bukuKiaController;
  final dynamic Function(int, int, bool)? onSelectedBukuKia;
  final bool showBukuKiaValidate;
  final GroupButtonController imdController;
  final dynamic Function(int, int, bool)? onSelectedImd;
  final bool showImdValidate;
  final TextEditingController nikOrtuController;
  final TextEditingController namaOrtuController;
  final TextEditingController noTelpOrtuController;
  final TextEditingController alamatController;
  final TextEditingController rtController;
  final TextEditingController rwController;
  final GroupButtonController pendudukBandungController;
  final dynamic Function(int, int, bool)? onSelectedPendudukBandung;
  final bool showPendudukBandungValidate;
  final TextEditingController kecamatanController;
  final TextEditingController kelurahanController;
  final TextEditingController puskesmasController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseFormGroupField(
            label: 'NIK',
            hint: 'Masukkan NIK balita',
            mandatory: true,
            controller: nikAnakController,
            maxLength: 16,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan NIK balita';
              } else {
                if (value.length < 16 && value.length > 16) {
                  return 'NIK balita harus berjumlah 16 digit';
                }
              }

              return null;
            },
          ),
          SizedBox(height: 8.h),
          BaseFormInfo(
            message: 'Pastikan NIK yang anda input sudah benar',
            bgColor: Colors.teal.shade100,
            fgColor: Colors.teal.shade700,
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'No. Kartu Keluarga',
            hint: 'Masukkan no. kartu keluarga',
            mandatory: true,
            controller: noKkController,
            maxLength: 16,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan no. kartu keluarga';
              } else {
                if (value.length < 16 && value.length > 16) {
                  return 'No. kartu keluarga harus berjumlah 16 digit';
                }
              }

              return null;
            },
          ),
          SizedBox(height: 8.h),
          BaseFormInfo(
            message: 'Pastikan No. KK yang anda input sudah benar',
            bgColor: Colors.teal.shade100,
            fgColor: Colors.teal.shade700,
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Nama Balita',
            hint: 'Masukkan nama balita',
            mandatory: true,
            controller: namaBalitaController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan nama balita';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseDatePickerGroupField(
            label: 'Tanggal Lahir',
            hint: 'Pilih tanggal lahir balita',
            mandatory: true,
            controller: tglLahirController,
            pickerModel: DatePickerModel(
              locale: LocaleType.id,
              currentTime: selectedTglLahir ?? DateTime.now(),
            ),
            onConfirmDate: onConfirmTglLahir,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon pilih tanggal lahir balita';
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
                    text: 'Jenis Kelamin',
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
            controller: jenisKelaminController,
            isRadio: true,
            buttons: ['Laki-laki', 'Perempuan'],
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
                      index == 0 ? 'Laki-laki' : 'Perempuan',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
            onSelected: onSelectedJenisKelamin,
          ),
          if (showJenisKelaminValidate) SizedBox(height: 4.h),
          if (showJenisKelaminValidate)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih jenis kelamin balita',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Anak Ke',
            hint: 'Contoh: 1',
            mandatory: true,
            controller: anakKeController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan anak ke berapa';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: BaseFormGroupField(
                  label: 'Berat Lahir',
                  hint: 'Contoh: 3.5',
                  mandatory: true,
                  controller: beratLahirController,
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
                      return 'Mohon masukkan berat lahir balita';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: BaseFormGroupField(
                  label: 'Panjang Lahir',
                  hint: 'Contoh: 50',
                  mandatory: true,
                  controller: panjangLahirController,
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
                      return 'Mohon masukkan panjang lahir balita';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Lingkar Kepala Lahir',
            hint: 'Contoh: 20',
            mandatory: true,
            controller: lingkarKepalaController,
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                'cm',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan lingkar kepala lahir balita';
              }

              return null;
            },
          ),
          SizedBox(height: 8.h),
          BaseFormInfo(
            message: 'Gunakan titik (.) untuk koma',
            bgColor: Colors.teal.shade100,
            fgColor: Colors.teal.shade700,
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Usia Kehamilan',
            hint: 'Contoh: 38',
            mandatory: true,
            controller: usiaKehamilanController,
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                'minggu',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan usia kehamilan';
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
                    text: 'KIA Bayi Kecil?',
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
            controller: kiaBayiKecilController,
            isRadio: true,
            buttons: [true, false],
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
            onSelected: onSelectedKiaBayiKecil,
          ),
          if (showKiaBayiKecilValidate) SizedBox(height: 4.h),
          if (showKiaBayiKecilValidate)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih KIA bayi kecil',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Mempunyai Buku KIA?',
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
            controller: bukuKiaController,
            isRadio: true,
            buttons: [1, 0],
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
            onSelected: onSelectedBukuKia,
          ),
          if (showBukuKiaValidate) SizedBox(height: 4.h),
          if (showBukuKiaValidate)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih mempunyai buku KIA',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'IMD',
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
            controller: imdController,
            isRadio: true,
            buttons: [1, 0],
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
            onSelected: onSelectedImd,
          ),
          if (showImdValidate) SizedBox(height: 4.h),
          if (showImdValidate)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih IMD',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'NIK Orang Tua atau NIK Panti',
            hint: 'Salah satunya saja (Ayah atau Ibu)',
            mandatory: true,
            controller: nikOrtuController,
            maxLength: 16,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan NIK orang tua atau NIK panti';
              } else {
                if (value.length < 16 && value.length > 16) {
                  return 'NIK orang tua atau NIK panti harus berjumlah 16 digit';
                }
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Nama Orang Tua atau Nama Panti',
            hint: 'Masukkan nama orang tua atau nama panti',
            mandatory: true,
            controller: namaOrtuController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan nama orang tua atau nama panti';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'No. HP Orang Tua atau No. HP Panti',
            hint: 'Salah satunya saja (Ayah atau Ibu)',
            mandatory: true,
            controller: noTelpOrtuController,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan no. hp orang tua atau no. hp panti';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Alamat',
            hint: 'Masukkan alamat',
            mandatory: true,
            controller: alamatController,
            keyboardType: TextInputType.streetAddress,
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan alamat';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: BaseFormGroupField(
                  label: 'RT',
                  hint: 'Masukkan RT',
                  mandatory: true,
                  controller: rtController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mohon masukkan RT';
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: BaseFormGroupField(
                  label: 'RW',
                  hint: 'Masukkan RW',
                  mandatory: true,
                  controller: rwController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mohon masukkan RW';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Penduduk Kota Bandung?',
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
            controller: pendudukBandungController,
            isRadio: true,
            buttons: [1, 0],
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
            onSelected: onSelectedPendudukBandung,
          ),
          if (showPendudukBandungValidate) SizedBox(height: 4.h),
          if (showPendudukBandungValidate)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mohon pilih apakah penduduk Kota Bandung',
                style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
              ),
            ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Kecamatan',
            hint: 'Masukkan kecamatan',
            mandatory: true,
            readOnly: true,
            controller: kecamatanController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan kecamatan';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Kelurahan',
            hint: 'Masukkan kelurahan',
            mandatory: true,
            readOnly: true,
            controller: kelurahanController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan kelurahan';
              }

              return null;
            },
          ),
          SizedBox(height: 10.h),
          BaseFormGroupField(
            label: 'Puskesmas',
            hint: 'Masukkan puskesmas',
            mandatory: true,
            readOnly: true,
            controller: puskesmasController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan puskesmas';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
