import 'dart:math';

import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_datepickerfield.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_forminfo.dart';
import 'package:epenting/app/widgets/base_iconbutton.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:group_button/group_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class AddBalitaForm extends StatefulWidget {
  const AddBalitaForm({super.key});

  @override
  State<AddBalitaForm> createState() => _AddBalitaFormState();
}

class _AddBalitaFormState extends State<AddBalitaForm> {
  final _formKey = GlobalKey<FormState>();
  final _statusBalitaController = GroupButtonController(selectedIndex: 0);
  String selectedStatusBalita = 'baru';
  final _nikBalitaController = TextEditingController();
  final _noKKController = TextEditingController();
  final _namaBalitaController = TextEditingController();
  int? selectedIdBalita;
  final _tglLahirController = TextEditingController();
  DateTime? selectedTglLahir;
  String? selectedTglLahirString;
  final _jenisKelaminController = GroupButtonController(selectedIndex: 0);
  String selectedJenisKelamin = 'laki-laki';
  final _anakKeController = TextEditingController();
  final _beratLahirController = TextEditingController();
  final _panjangLahirController = TextEditingController();
  final _lingkarKepalaLahirController = TextEditingController();
  final _usiaKehamilanController = TextEditingController();
  final _kiaBayiKecilController = GroupButtonController(selectedIndex: 1);
  String selectedKiaBayiKecil = 'tidak';
  final _bukuKiaController = GroupButtonController(selectedIndex: 1);
  String selectedBukuKia = 'tidak';
  final _imdController = GroupButtonController(selectedIndex: 1);
  String selectedImd = 'tidak';
  final _nikOrtuController = TextEditingController();
  final _namaOrtuController = TextEditingController();
  final _noTelpOrtuController = TextEditingController();
  final _alamatController = TextEditingController();
  final _rtController = TextEditingController();
  final _rwController = TextEditingController();
  final _pendudukBandungController = GroupButtonController(selectedIndex: 1);
  String selectedPendudukBandung = 'tidak';
  final _asalKecamatanController = TextEditingController();
  final _asalKelurahanController = TextEditingController();
  final _asalPuskesmasController = TextEditingController();
  final _tujuanKecamatanController = TextEditingController();
  final _tujuanKelurahanController = TextEditingController();
  final _tujuanPuskesmasController = TextEditingController();

  @override
  void initState() {
    _tujuanKecamatanController.text =
        context.read<AuthCubit>().state.profile?.namaKecamatan ?? '';
    _tujuanKelurahanController.text =
        context.read<AuthCubit>().state.profile?.namaKelurahan ?? '';
    _tujuanPuskesmasController.text =
        context.read<AuthCubit>().state.profile?.namaPuskesmas ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _statusBalitaController.dispose();
    _nikBalitaController.dispose();
    _noKKController.dispose();
    _namaBalitaController.dispose();
    _tglLahirController.dispose();
    _jenisKelaminController.dispose();
    _anakKeController.dispose();
    _beratLahirController.dispose();
    _panjangLahirController.dispose();
    _lingkarKepalaLahirController.dispose();
    _usiaKehamilanController.dispose();
    _kiaBayiKecilController.dispose();
    _bukuKiaController.dispose();
    _imdController.dispose();
    _nikOrtuController.dispose();
    _namaOrtuController.dispose();
    _noTelpOrtuController.dispose();
    _alamatController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _pendudukBandungController.dispose();
    _asalKecamatanController.dispose();
    _asalKelurahanController.dispose();
    _asalPuskesmasController.dispose();
    _tujuanKecamatanController.dispose();
    _tujuanKelurahanController.dispose();
    _tujuanPuskesmasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(
          width: double.infinity,
          child: Material(
            elevation: 1,
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'Status Balita?',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GroupButton(
                      controller: _statusBalitaController,
                      isRadio: true,
                      buttons: ['baru', 'pindah'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                index == 0 ? 'Baru' : 'Pindah',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      onSelected: (value, index, isSelected) {
                        if (selectedStatusBalita != value) {
                          setState(() {
                            selectedStatusBalita = value;
                          });

                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            FocusScope.of(context).unfocus();
                            _formKey.currentState?.reset();
                          });
                          _nikBalitaController.clear();
                          _noKKController.clear();
                          _namaBalitaController.clear();
                          setState(() {
                            selectedIdBalita = null;
                            selectedTglLahir = null;
                            selectedTglLahirString = null;
                            selectedJenisKelamin = 'laki-laki';
                            selectedKiaBayiKecil = 'tidak';
                            selectedBukuKia = 'tidak';
                            selectedImd = 'tidak';
                            selectedPendudukBandung = 'tidak';
                          });
                          _tglLahirController.clear();
                          _jenisKelaminController.selectIndex(0);
                          _anakKeController.clear();
                          _beratLahirController.clear();
                          _panjangLahirController.clear();
                          _lingkarKepalaLahirController.clear();
                          _usiaKehamilanController.clear();
                          _kiaBayiKecilController.selectIndex(1);
                          _bukuKiaController.selectIndex(1);
                          _imdController.selectIndex(1);
                          _nikOrtuController.clear();
                          _namaOrtuController.clear();
                          _noTelpOrtuController.clear();
                          _alamatController.clear();
                          _rtController.clear();
                          _rwController.clear();
                          _pendudukBandungController.selectIndex(1);
                          _asalKecamatanController.clear();
                          _asalKelurahanController.clear();
                          _asalPuskesmasController.clear();
                        }
                      },
                    ),
                    if (selectedStatusBalita == 'pindah') ...{
                      SizedBox(height: 10.h),
                      BaseFormInfo(
                        bgColor: Colors.teal.shade100,
                        fgColor: Colors.teal.shade700,
                        message:
                            'Silahkan ketik dan pilih nama balita, maka seluruh kolom isian dibawah ini akan otomatis terisi berdasarkan data balita yang dipilih.',
                      ),
                    },
                    SizedBox(height: 10.h),
                    BlocListener<BalitaCubit, BalitaState>(
                      listenWhen:
                          (previous, current) =>
                              previous.checkNikStatus != current.checkNikStatus,
                      listener: (context, state) {
                        if (state.checkNikStatus == CheckNikStatus.success) {
                          context.loaderOverlay.hide();
                          showCustomToast(
                            context,
                            type: ToastificationType.success,
                            title: 'NIK dapat digunakan',
                          );
                        }

                        if (state.checkNikStatus == CheckNikStatus.error) {
                          context.loaderOverlay.hide();
                          showCustomToast(
                            context,
                            type: ToastificationType.error,
                            title: state.checkNikError,
                          );
                        }
                      },
                      child: BaseFormGroupField(
                        label: 'NIK Balita',
                        hint: 'Masukkan NIK balita',
                        mandatory: true,
                        controller: _nikBalitaController,
                        readOnly: selectedStatusBalita == 'baru' ? false : true,
                        keyboardType: TextInputType.number,
                        maxLength: 16,
                        onChanged: (value) {
                          if (value?.length == 16) {
                            context.loaderOverlay.show();
                            context.read<BalitaCubit>().checkNikBalita(
                              nik: _nikBalitaController.text,
                            );
                          }
                        },
                        suffixIcon:
                            selectedStatusBalita == 'baru'
                                ? BaseIconButton(
                                  icon: IonIcons.dice,
                                  size: 18.sp,
                                  color: AppColors.orangeColor,
                                  onPressed: () {
                                    context.loaderOverlay.show();

                                    final random = Random();
                                    String nik = '';
                                    for (int i = 0; i < 16; i++) {
                                      int digit =
                                          i == 0
                                              ? random.nextInt(9) + 1
                                              : random.nextInt(10);
                                      nik += digit.toString();
                                    }

                                    if (nik.isNotEmpty) {
                                      _nikBalitaController.text =
                                          nik.toString();

                                      if (context.mounted) {
                                        context
                                            .read<BalitaCubit>()
                                            .checkNikBalita(
                                              nik: _nikBalitaController.text,
                                            );
                                      }
                                    }
                                  },
                                )
                                : null,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan NIK balita dengan memilih nama balita';
                          }

                          return null;
                        },
                      ),
                    ),
                    if (selectedStatusBalita == 'baru') ...{
                      SizedBox(height: 8.h),
                      BaseFormInfo(
                        bgColor: Colors.teal.shade100,
                        fgColor: Colors.teal.shade700,
                        message: 'Pastikan NIK yang diinputkan sudah benar',
                      ),
                    },
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'No. Kartu Keluarga',
                      hint: 'Masukkan no. kartu keluarga',
                      mandatory: true,
                      controller: _noKKController,
                      readOnly: selectedStatusBalita == 'pindah' ? true : false,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon masukkan no. kartu keluarga dengan memilih nama balita';
                        }

                        return null;
                      },
                    ),
                    if (selectedStatusBalita == 'baru') ...{
                      SizedBox(height: 8.h),
                      BaseFormInfo(
                        bgColor: Colors.teal.shade100,
                        fgColor: Colors.teal.shade700,
                        message:
                            'Pastikan No. Kartu Keluarga yang diinputkan sudah benar',
                      ),
                    },
                    SizedBox(height: 10.h),
                    if (selectedStatusBalita == 'baru') ...{
                      BaseFormGroupField(
                        label: 'Nama Balita',
                        hint: 'Masukkan nama balita',
                        mandatory: true,
                        controller: _namaBalitaController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan nama balita';
                          }

                          return null;
                        },
                      ),
                    } else ...{
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
                        controller: _namaBalitaController,
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            child: Text(
                              'Balita Tidak Ditemukan!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                        itemBuilder: (context, value) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            child: Text(
                              value.namaAnak ?? '',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          );
                        },
                        onSelected: (value) {
                          setState(() {
                            selectedIdBalita = value.id;
                            selectedJenisKelamin =
                                value.jenisKelamin?.toLowerCase() ?? '';
                            selectedKiaBayiKecil =
                                value.kiaBayiKecil == 1 ? 'ya' : 'tidak';
                            selectedBukuKia = value.kia == 1 ? 'ya' : 'tidak';
                            selectedImd = value.imd == 1 ? 'ya' : 'tidak';
                            selectedPendudukBandung =
                                value.pendudukKotaBandung == 1 ? 'ya' : 'tidak';
                          });
                          _nikBalitaController.text = value.nikAnak ?? '';
                          _noKKController.text = value.noKk ?? '';
                          _namaBalitaController.text = value.namaAnak ?? '';
                          _tglLahirController
                              .text = AppHelpers.dayMonthYearFormat(
                            value.tanggalLahir ?? DateTime(0000),
                          );
                          _jenisKelaminController.selectIndex(
                            selectedJenisKelamin == 'laki-laki' ? 0 : 1,
                          );
                          _anakKeController.text =
                              value.anakKe?.toString() ?? '1';
                          _beratLahirController
                              .text = AppHelpers.formatDoubleToString(
                            value.beratLahir ?? 0,
                          );
                          _panjangLahirController
                              .text = AppHelpers.formatDoubleToString(
                            value.tinggi ?? 0,
                          );
                          _lingkarKepalaLahirController
                              .text = AppHelpers.formatDoubleToString(
                            value.lingkarKepalaLahir ?? 0,
                          );
                          _usiaKehamilanController.text =
                              value.usiaKehamilan?.toString() ?? '0';
                          _kiaBayiKecilController.selectIndex(
                            value.kiaBayiKecil == 1 ? 0 : 1,
                          );
                          _bukuKiaController.selectIndex(
                            value.kiaBayiKecil == 1 ? 0 : 1,
                          );
                          _imdController.selectIndex(value.imd == 1 ? 0 : 1);
                          _nikOrtuController.text = value.nikAyah ?? '';
                          _namaOrtuController.text = value.namaAyah ?? '';
                          _noTelpOrtuController.text = value.nomorTelepon ?? '';
                          _alamatController.text = value.alamat ?? '';
                          _rtController.text = value.rt ?? '';
                          _rwController.text = value.rw ?? '';
                          _pendudukBandungController.selectIndex(
                            value.pendudukKotaBandung == 1 ? 0 : 1,
                          );
                          _asalKecamatanController.text =
                              value.namaKecamatan ?? '';
                          _asalKelurahanController.text =
                              value.namaKelurahan ?? '';
                          _asalPuskesmasController.text =
                              value.namaPuskesmas ?? '';
                        },
                        suggestionsCallback:
                            (keyword) => context
                                .read<BalitaCubit>()
                                .searchPindahBalita(keyword),
                      ),
                    },
                    SizedBox(height: 10.h),
                    if (selectedStatusBalita == 'baru') ...{
                      BaseDatePickerGroupField(
                        label: 'Tanggal Lahir',
                        hint: 'Masukkan tanggal lahir',
                        mandatory: true,
                        controller: _tglLahirController,
                        pickerModel: DatePickerModel(
                          locale: LocaleType.id,
                          currentTime: DateTime.now(),
                        ),
                        onConfirmDate: (date) {
                          setState(() {
                            selectedTglLahirString =
                                AppHelpers.databaseDateFormat(date);
                            selectedTglLahir = DateFormat(
                              'yyyy-MM-dd',
                            ).parse(selectedTglLahirString ?? '');
                          });
                          _tglLahirController
                              .text = AppHelpers.dayMonthYearFormat(date);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan tanggal lahir dengan memilih nama balita';
                          }

                          return null;
                        },
                      ),
                    } else ...{
                      BaseFormGroupField(
                        label: 'Tanggal Lahir',
                        hint: 'Masukkan tanggal lahir',
                        mandatory: true,
                        controller: _tglLahirController,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mohon masukkan tanggal lahir dengan memilih nama balita';
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
                      controller: _jenisKelaminController,
                      isRadio: true,
                      options: GroupButtonOptions(),
                      buttons: ['laki-laki', 'perempuan'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
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
                      onSelected: (value, index, isSelected) {
                        if (selectedJenisKelamin != value) {
                          setState(() {
                            selectedJenisKelamin = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'Anak Ke',
                      hint: 'Contoh: 1',
                      mandatory: true,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      controller: _anakKeController,
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
                            readOnly:
                                selectedStatusBalita == 'baru' ? false : true,
                            controller: _beratLahirController,
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
                                return 'Mohon masukkan berat lahir';
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
                            readOnly:
                                selectedStatusBalita == 'baru' ? false : true,
                            controller: _panjangLahirController,
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
                                return 'Mohon masukkan panjang lahir';
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
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      controller: _lingkarKepalaLahirController,
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
                          return 'Mohon masukkan lingkar kepala lahir';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    BaseFormInfo(
                      bgColor: Colors.teal.shade100,
                      fgColor: Colors.teal.shade700,
                      message: 'Gunakan titik (.) untuk koma',
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'Usia Kehamilan',
                      hint: 'Contoh: 38',
                      mandatory: true,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      controller: _usiaKehamilanController,
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          'minggu',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon masukkan lusia kehamilan';
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
                      controller: _kiaBayiKecilController,
                      isRadio: true,
                      buttons: ['ya', 'tidak'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
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
                      onSelected: (value, index, isSelected) {
                        if (selectedKiaBayiKecil != value) {
                          setState(() {
                            selectedKiaBayiKecil = value;
                          });
                        }
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
                      controller: _bukuKiaController,
                      isRadio: true,
                      buttons: ['ya', 'tidak'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
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
                      onSelected: (value, index, isSelected) {
                        if (selectedBukuKia != value) {
                          setState(() {
                            selectedBukuKia = value;
                          });
                        }
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
                      controller: _imdController,
                      isRadio: true,
                      buttons: ['ya', 'tidak'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
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
                      onSelected: (value, index, isSelected) {
                        if (selectedImd != value) {
                          setState(() {
                            selectedImd = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'NIK Orang Tua atau NIK Panti',
                      hint: 'Masukkan NIK orang tua atau NIK panti',
                      mandatory: true,
                      controller: _nikOrtuController,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon masukkan NIK orangtua atau NIK panti';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'Nama Orang Tua atau Nama Panti',
                      hint: 'Masukkan nama orang tua atau nama panti',
                      mandatory: true,
                      controller: _namaOrtuController,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon masukkan nama orangtua atau nama panti';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'No. HP Orang Tua atau No. HP Panti',
                      hint: 'Masukkan no. hp orang tua atau no. hp panti',
                      mandatory: true,
                      controller: _noTelpOrtuController,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
                      keyboardType: TextInputType.phone,
                      maxLength: 13,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon masukkan no. hp orangtua atau no. hp panti';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    BaseFormGroupField(
                      label: 'Alamat',
                      hint: 'Masukkan alamat',
                      mandatory: true,
                      controller: _alamatController,
                      readOnly: selectedStatusBalita == 'baru' ? false : true,
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
                            controller: _rtController,
                            readOnly:
                                selectedStatusBalita == 'baru' ? false : true,
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
                            controller: _rwController,
                            readOnly:
                                selectedStatusBalita == 'baru' ? false : true,
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
                      controller: _pendudukBandungController,
                      isRadio: true,
                      buttons: ['ya', 'tidak'],
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
                                  color:
                                      selected
                                          ? AppColors.blueColor
                                          : Colors.white,
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
                      onSelected: (value, index, isSelected) {
                        if (selectedPendudukBandung != value) {
                          setState(() {
                            selectedPendudukBandung = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        if (selectedStatusBalita == 'pindah') ...{
                          Expanded(
                            child: Column(
                              children: [
                                BaseFormGroupField(
                                  label: 'Kecamatan Asal',
                                  hint: 'Masukkan kecamatan asal',
                                  mandatory: true,
                                  controller: _asalKecamatanController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Mohon masukkan kecamatan asal';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.h),
                                BaseFormGroupField(
                                  label: 'Kelurahan Asal',
                                  hint: 'Masukkan kelurahan asal',
                                  mandatory: true,
                                  controller: _asalKelurahanController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Mohon masukkan kelurahan asal';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.h),
                                BaseFormGroupField(
                                  label: 'Puskesmas Asal',
                                  hint: 'Masukkan puskesmas asal',
                                  mandatory: true,
                                  controller: _asalPuskesmasController,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Mohon masukkan puskesmas asal';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                        },
                        Expanded(
                          child: Column(
                            children: [
                              BaseFormGroupField(
                                label: 'Kecamatan Tujuan',
                                hint: 'Masukkan kecamatan tujuan',
                                mandatory: true,
                                controller: _tujuanKecamatanController,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon masukkan kecamatan tujuan';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 10.h),
                              BaseFormGroupField(
                                label: 'Kelurahan Tujuan',
                                hint: 'Masukkan kelurahan tujuan',
                                mandatory: true,
                                controller: _tujuanKelurahanController,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon masukkan kelurahan tujuan';
                                  }

                                  return null;
                                },
                              ),
                              SizedBox(height: 10.h),
                              BaseFormGroupField(
                                label: 'Puskesmas Tujuan',
                                hint: 'Masukkan puskesmas tujuan',
                                mandatory: true,
                                controller: _tujuanPuskesmasController,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Mohon masukkan puskesmas tujuan';
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        BlocListener<BalitaCubit, BalitaState>(
          listenWhen:
              (previous, current) => previous.formStatus != current.formStatus,
          listener: (context, state) {
            if (state.formStatus == FormStatus.loading) {
              context.loaderOverlay.show();
            }

            if (state.formStatus == FormStatus.success) {
              context.loaderOverlay.hide();
              Navigator.pop(context);
              showCustomToast(
                context,
                type: ToastificationType.success,
                title: 'Tambah Balita Berhasil',
                description:
                    'Data balita dengan nama ${_namaBalitaController.text} berhasil ${selectedStatusBalita == 'baru' ? 'ditambahkan' : 'dipindahkan'}',
              );
              context.read<BalitaCubit>().resetAddFormState();
              context.read<DashboardCubit>().refetchLatestBalita();
              context.read<BalitaCubit>().refetchAllBalita();
            }

            if (state.formStatus == FormStatus.error) {
              context.loaderOverlay.hide();
              showCustomToast(
                context,
                type: ToastificationType.error,
                title: 'Tambah Balita Gagal',
                description: state.formError,
              );
            }
          },
          child: SizedBox(
            width: double.infinity,
            child: BaseButtonIcon(
              bgColor: AppColors.blueColor,
              fgColor: Colors.white,
              icon: MingCute.save_2_line,
              label: 'Simpan',
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<BalitaCubit>().createBalita(
                    statusBalita: selectedStatusBalita,
                    idBalita: selectedIdBalita,
                    nik: _nikBalitaController.text,
                    noKk: _noKKController.text,
                    namaBalita: _namaBalitaController.text,
                    tglLahir: selectedTglLahirString,
                    jenisKelamin: selectedJenisKelamin,
                    anakKe: _anakKeController.text,
                    beratLahir: _beratLahirController.text,
                    tinggiLahir: _panjangLahirController.text,
                    lingkarKepalaLahir: _lingkarKepalaLahirController.text,
                    usiaKehamilan: _usiaKehamilanController.text,
                    kiaBayiKecil: selectedKiaBayiKecil,
                    bukuKia: selectedBukuKia,
                    imd: selectedImd,
                    nikOrtu: _nikOrtuController.text,
                    namaOrtu: _namaOrtuController.text,
                    noTelp: _noTelpOrtuController.text,
                    alamat: _alamatController.text,
                    rt: _rtController.text,
                    rw: _rwController.text,
                    pendudukBandung: selectedPendudukBandung,
                    idKecamatan:
                        context.read<AuthCubit>().state.profile?.kecamatan,
                    idKelurahan:
                        context.read<AuthCubit>().state.profile?.kelurahan,
                    idPuskesmas:
                        context.read<AuthCubit>().state.profile?.puskesmas,
                    idPosyandu:
                        context.read<AuthCubit>().state.profile?.posyandu,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
