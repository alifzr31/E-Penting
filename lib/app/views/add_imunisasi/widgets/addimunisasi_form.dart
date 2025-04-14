import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/models/vaccine.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/add_imunisasi/components/addimunisasibalita_form.dart';
import 'package:epenting/app/views/add_imunisasi/components/vaccine_item.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_datepickerfield.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class AddImunsiasiForm extends StatefulWidget {
  const AddImunsiasiForm({super.key});

  @override
  State<AddImunsiasiForm> createState() => _AddImunsiasiFormState();
}

class _AddImunsiasiFormState extends State<AddImunsiasiForm> {
  final _formKey = GlobalKey<FormState>();
  final _tglImunisasiController = TextEditingController();
  DateTime? selectedTglImunisasi;
  String? selectedTglImunisasiString;
  final _namaBalitaController = TextEditingController();
  int? selectedIdBalita;
  final _nikBalitaController = TextEditingController();
  final _tglLahirController = TextEditingController();
  List<String> selectedVaccine = [];
  bool showVaccineValidate = false;
  final vaccines = const [
    Vaccine(name: 'HB', id: 'hb'),
    Vaccine(name: 'DPT-HB 1', id: 'dpt_hb1'),
    Vaccine(name: 'DPT-HB 2', id: 'dpt_hb2'),
    Vaccine(name: 'DPT-HB 3', id: 'dpt_hb3'),
    Vaccine(name: 'DPT-HB L', id: 'dpt_hbl'),
    Vaccine(name: 'Polio 1', id: 'polio1'),
    Vaccine(name: 'Polio 2', id: 'polio2'),
    Vaccine(name: 'Polio 3', id: 'polio3'),
    Vaccine(name: 'Polio 4', id: 'polio4'),
    Vaccine(name: 'Campak', id: 'campak'),
    Vaccine(name: 'Campak L', id: 'campak_l'),
    Vaccine(name: 'BCG', id: 'bcg'),
    Vaccine(name: 'IPV 1', id: 'ipv_1'),
    Vaccine(name: 'IPV 2', id: 'ipv_2'),
    Vaccine(name: 'ROTAV 1', id: 'rotav_1'),
    Vaccine(name: 'ROTAV 2', id: 'rotav_2'),
    Vaccine(name: 'ROTAV 3', id: 'rotav_3'),
    Vaccine(name: 'PCV 1', id: 'pcv_1'),
    Vaccine(name: 'PCV 2', id: 'pcv_2'),
    Vaccine(name: 'PCV 3', id: 'pcv_3'),
  ];

  @override
  void dispose() {
    _tglImunisasiController.dispose();
    _namaBalitaController.dispose();
    _nikBalitaController.dispose();
    _tglLahirController.dispose();
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
                    BaseDatePickerGroupField(
                      label: 'Tanggal Pengukuran',
                      hint: 'Pilih tanggal pengukuran',
                      mandatory: true,
                      controller: _tglImunisasiController,
                      pickerModel: DatePickerModel(
                        locale: LocaleType.id,
                        currentTime: selectedTglImunisasi ?? DateTime.now(),
                      ),
                      onConfirmDate: (date) {
                        setState(() {
                          selectedTglImunisasiString =
                              AppHelpers.databaseDateFormat(date);
                          selectedTglImunisasi = DateFormat(
                            'yyyy-MM-dd',
                          ).parse(selectedTglImunisasiString ?? '');
                        });
                        _tglImunisasiController
                            .text = AppHelpers.dayMonthYearFormat(date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mohon pilih tanggal pengukuran';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    AddImunisasiBalitaForm(
                      namaBalitaController: _namaBalitaController,
                      onSelectedNamaBalita: (value) {
                        setState(() {
                          selectedIdBalita = value.id;
                        });
                        _namaBalitaController.text = value.namaAnak ?? '';
                        _nikBalitaController.text = value.nikAnak ?? '';
                        _tglLahirController
                            .text = AppHelpers.dayMonthYearFormat(
                          value.tanggalLahir ?? DateTime(0000),
                        );
                      },
                      nikBalitaController: _nikBalitaController,
                      tglLahirController: _tglLahirController,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'Jenis Imunisasi',
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(
                              vaccines.sublist(0, 10).length,
                              (index) {
                                return Column(
                                  children: [
                                    VaccineItem(
                                      label:
                                          vaccines.sublist(0, 10)[index].name ??
                                          '',
                                      color:
                                          selectedVaccine.contains(
                                                vaccines
                                                        .sublist(0, 10)[index]
                                                        .id ??
                                                    '',
                                              )
                                              ? AppColors.blueColor
                                              : Colors.white,
                                      onSelectedVaccine: () {
                                        if (selectedVaccine.contains(
                                          vaccines.sublist(0, 10)[index].id ??
                                              '',
                                        )) {
                                          setState(() {
                                            selectedVaccine.remove(
                                              vaccines
                                                      .sublist(0, 10)[index]
                                                      .id ??
                                                  '',
                                            );
                                          });
                                        } else {
                                          setState(() {
                                            selectedVaccine.add(
                                              vaccines
                                                      .sublist(0, 10)[index]
                                                      .id ??
                                                  '',
                                            );
                                          });
                                        }
                                      },
                                    ),
                                    if (index != 9) SizedBox(height: 4.h),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: List.generate(
                              vaccines.sublist(10, 20).length,
                              (index) {
                                return Column(
                                  children: [
                                    VaccineItem(
                                      label:
                                          vaccines
                                              .sublist(10, 20)[index]
                                              .name ??
                                          '',
                                      color:
                                          selectedVaccine.contains(
                                                vaccines
                                                        .sublist(10, 20)[index]
                                                        .id ??
                                                    '',
                                              )
                                              ? AppColors.blueColor
                                              : Colors.white,
                                      onSelectedVaccine: () {
                                        if (selectedVaccine.contains(
                                          vaccines.sublist(10, 20)[index].id ??
                                              '',
                                        )) {
                                          setState(() {
                                            selectedVaccine.remove(
                                              vaccines
                                                      .sublist(10, 20)[index]
                                                      .id ??
                                                  '',
                                            );
                                          });
                                        } else {
                                          setState(() {
                                            selectedVaccine.add(
                                              vaccines
                                                      .sublist(10, 20)[index]
                                                      .id ??
                                                  '',
                                            );
                                          });
                                        }
                                      },
                                    ),
                                    if (index != 19) SizedBox(height: 4.h),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (showVaccineValidate) ...{
                      SizedBox(height: 4.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mohon pilih jenis imunisasi',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ),
                    },
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        BlocListener<ImunisasiCubit, ImunisasiState>(
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
                title: 'Tambah Imunisasi Berhasil',
                description:
                    'Data imunisasi balita ${_namaBalitaController.text} berhasil ditambahkan',
              );
              context.read<ImunisasiCubit>().resetAddFormState();
              context.read<DashboardCubit>().refetchLatestImunisasi();
              context.read<ImunisasiCubit>().refetchAllImunisasi();
            }

            if (state.formStatus == FormStatus.error) {
              context.loaderOverlay.hide();
              showCustomToast(
                context,
                type: ToastificationType.error,
                title: 'Tambah Imunisasi Gagal',
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
                  setState(() {
                    showVaccineValidate =
                        selectedVaccine.isEmpty ? true : false;
                  });

                  if (selectedVaccine.isNotEmpty) {
                    context.read<ImunisasiCubit>().addImunisasi(
                      idBalita: selectedIdBalita,
                      tglImunisasi: selectedTglImunisasiString,
                      selectedVaccine: selectedVaccine,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
