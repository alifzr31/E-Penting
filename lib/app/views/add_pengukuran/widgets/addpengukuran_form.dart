import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/add_pengukuran/components/balita_form.dart';
import 'package:epenting/app/views/add_pengukuran/components/pemberianasi_item.dart';
import 'package:epenting/app/views/add_pengukuran/components/pengukuran_form.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_datepickerfield.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class AddPengukuranForm extends StatefulWidget {
  const AddPengukuranForm({super.key});

  @override
  State<AddPengukuranForm> createState() => _AddPengukuranFormState();
}

class _AddPengukuranFormState extends State<AddPengukuranForm> {
  final _formKey = GlobalKey<FormState>();
  final _tglPengukuranController = TextEditingController();
  DateTime? selectedTglPengukuran;
  String? selectedTglPengukuranString;
  final _namaBalitaController = TextEditingController();
  int? selectedIdBalita;
  final _nikBalitaController = TextEditingController();
  final _tglLahirController = TextEditingController();
  final _caraPengukuranController = GroupButtonController();
  String selectedCaraPengukuran = 'terlentang';
  final _beratBadanController = TextEditingController();
  final _panjangBadanController = TextEditingController();
  final _lilaController = TextEditingController();
  final _lingkarKepalaController = TextEditingController();
  List<String> selectedAsi = [];
  final _pemberianVitAController = GroupButtonController();
  String selectedPemberianVitA = 'tidak';
  final _jumlahPemberianController = TextEditingController();
  final _pittingEdemaController = GroupButtonController();
  String selectedPittingEdema = 'tidak';
  final _derajatController = GroupButtonController();
  int? selectedDerajat;
  bool showDerajatValidate = false;
  final _kelasIbuBalitaController = GroupButtonController();
  String selectedKelasIbuBalita = 'tidak';

  @override
  void initState() {
    _caraPengukuranController.selectIndex(1);
    _pemberianVitAController.selectIndex(1);
    _pittingEdemaController.selectIndex(1);
    _kelasIbuBalitaController.selectIndex(1);
    super.initState();
  }

  @override
  void dispose() {
    _tglPengukuranController.dispose();
    _namaBalitaController.dispose();
    _nikBalitaController.dispose();
    _tglLahirController.dispose();
    _caraPengukuranController.dispose();
    _beratBadanController.dispose();
    _panjangBadanController.dispose();
    _lilaController.dispose();
    _lingkarKepalaController.dispose();
    _pemberianVitAController.dispose();
    _jumlahPemberianController.dispose();
    _pittingEdemaController.dispose();
    _derajatController.dispose();
    _kelasIbuBalitaController.dispose();
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
                      controller: _tglPengukuranController,
                      pickerModel: DatePickerModel(
                        locale: LocaleType.id,
                        currentTime: selectedTglPengukuran ?? DateTime.now(),
                      ),
                      onConfirmDate: (date) {
                        setState(() {
                          selectedTglPengukuranString =
                              AppHelpers.databaseDateFormat(date);
                          selectedTglPengukuran = DateFormat(
                            'yyyy-MM-dd',
                          ).parse(selectedTglPengukuranString ?? '');
                        });
                        _tglPengukuranController
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
                    BalitaForm(
                      namaBalitaController: _namaBalitaController,
                      onSelectedNamaBalita: (value) {
                        _namaBalitaController.text = value.namaAnak ?? '';
                        setState(() {
                          selectedIdBalita = value.id;
                        });
                        _nikBalitaController.text = value.nikAnak ?? '';
                        _tglLahirController
                            .text = AppHelpers.dayMonthYearFormat(
                          value.tanggalLahir ?? DateTime(0000),
                        );
                      },
                      nikBalitaController: _nikBalitaController,
                      tglLahirController: _tglLahirController,
                      caraPengukuranController: _caraPengukuranController,
                      onSelectedCaraPengukuran: (value, index, isSelected) {
                        setState(() {
                          selectedCaraPengukuran = value;
                        });
                      },
                      selectedCaraPengukuran: selectedCaraPengukuran,
                      beratBadanController: _beratBadanController,
                      panjangBadanController: _panjangBadanController,
                      lilaController: _lilaController,
                      lingkarKepalaController: _lingkarKepalaController,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'Pemberian ASI',
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: List.generate(4, (index) {
                              return Column(
                                children: [
                                  PemberianAsiItem(
                                    label:
                                        index == 0
                                            ? 'Bulan ke-0'
                                            : index == 1
                                            ? 'Bulan ke-2'
                                            : index == 2
                                            ? 'Bulan ke-4'
                                            : 'Bulan ke-6',
                                    color:
                                        selectedAsi.contains(
                                              index == 0
                                                  ? 'bulan0'
                                                  : index == 1
                                                  ? 'bulan2'
                                                  : index == 2
                                                  ? 'bulan4'
                                                  : 'bulan6',
                                            )
                                            ? AppColors.blueColor
                                            : Colors.white,
                                    onSelectedPemberianAsi: () {
                                      if (selectedAsi.contains(
                                        index == 0
                                            ? 'bulan0'
                                            : index == 1
                                            ? 'bulan2'
                                            : index == 2
                                            ? 'bulan4'
                                            : 'bulan6',
                                      )) {
                                        setState(() {
                                          selectedAsi.remove(
                                            index == 0
                                                ? 'bulan0'
                                                : index == 1
                                                ? 'bulan2'
                                                : index == 2
                                                ? 'bulan4'
                                                : 'bulan6',
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          selectedAsi.add(
                                            index == 0
                                                ? 'bulan0'
                                                : index == 1
                                                ? 'bulan2'
                                                : index == 2
                                                ? 'bulan4'
                                                : 'bulan6',
                                          );
                                        });
                                      }
                                    },
                                  ),
                                  if (index != 3) SizedBox(height: 4.h),
                                ],
                              );
                            }),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: List.generate(3, (index) {
                              return Column(
                                children: [
                                  PemberianAsiItem(
                                    label:
                                        index == 0
                                            ? 'Bulan ke-1'
                                            : index == 1
                                            ? 'Bulan ke-3'
                                            : 'Bulan ke-5',
                                    color:
                                        selectedAsi.contains(
                                              index == 0
                                                  ? 'bulan1'
                                                  : index == 1
                                                  ? 'bulan3'
                                                  : 'bulan5',
                                            )
                                            ? AppColors.blueColor
                                            : Colors.white,
                                    onSelectedPemberianAsi: () {
                                      if (selectedAsi.contains(
                                        index == 0
                                            ? 'bulan1'
                                            : index == 1
                                            ? 'bulan3'
                                            : 'bulan5',
                                      )) {
                                        setState(() {
                                          selectedAsi.remove(
                                            index == 0
                                                ? 'bulan1'
                                                : index == 1
                                                ? 'bulan3'
                                                : 'bulan5',
                                          );
                                        });
                                      } else {
                                        setState(() {
                                          selectedAsi.add(
                                            index == 0
                                                ? 'bulan1'
                                                : index == 1
                                                ? 'bulan3'
                                                : 'bulan5',
                                          );
                                        });
                                      }
                                    },
                                  ),
                                  if (index != 3) SizedBox(height: 4.h),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    PengukuranForm(
                      pemberianVitAController: _pemberianVitAController,
                      onSelectedPemberianVitA: (value, index, isSelected) {
                        if (selectedPemberianVitA != value) {
                          setState(() {
                            selectedPemberianVitA = value;
                          });
                          _jumlahPemberianController.clear();
                        }
                      },
                      selectedPemberianVitA: selectedPemberianVitA,
                      jumlahPemberianController: _jumlahPemberianController,
                      pittingEdemaController: _pittingEdemaController,
                      onSelectedPittingEdema: (value, index, isSelected) {
                        if (selectedPittingEdema != value) {
                          setState(() {
                            selectedPittingEdema = value;
                            selectedDerajat = null;
                            showDerajatValidate = false;
                          });
                          _derajatController.unselectAll();
                        }
                      },
                      selectedPittingEdema: selectedPittingEdema,
                      derajatController: _derajatController,
                      onSelectedDerajat: (value, index, isSelected) {
                        setState(() {
                          selectedDerajat = value;
                        });
                      },
                      showDerajatValidate: showDerajatValidate,
                      kelasIbuBalitaController: _kelasIbuBalitaController,
                      onSelectedKelasIbuBalita: (value, index, isSelected) {
                        setState(() {
                          selectedKelasIbuBalita = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        BlocListener<PengukuranCubit, PengukuranState>(
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
                title: 'Tambah Pengukuran Berhasil',
                description:
                    'Data pengukuran balita ${_namaBalitaController.text} berhasil ditambahkan',
              );
              context.read<PengukuranCubit>().resetAddFormState();
              context.read<DashboardCubit>().refetchLatestPengukuran();
              context.read<PengukuranCubit>().refetchAllPengukuran();
            }

            if (state.formStatus == FormStatus.error) {
              context.loaderOverlay.hide();
              showCustomToast(
                context,
                type: ToastificationType.error,
                title: 'Tambah Pengukuran Gagal',
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
                  if (selectedPittingEdema == 'ya') {
                    setState(() {
                      showDerajatValidate =
                          selectedDerajat == null ? true : false;
                    });

                    if (selectedDerajat != null) {
                      context.read<PengukuranCubit>().addPengukuran(
                        tglPengukuran: selectedTglPengukuranString,
                        idBalita: selectedIdBalita,
                        caraPengukuran: selectedCaraPengukuran,
                        beratBadan: _beratBadanController.text,
                        tinggiBadan: _panjangBadanController.text,
                        lila: _lilaController.text,
                        lingkarKepala: _lingkarKepalaController.text,
                        selectedAsi: selectedAsi,
                        pemberianVitA: selectedPemberianVitA,
                        jumlahPemberian: _jumlahPemberianController.text,
                        pittingEdema: selectedPittingEdema,
                        derajat: selectedDerajat,
                        kelasIbuBalita: selectedKelasIbuBalita,
                      );
                    }
                  } else {
                    context.read<PengukuranCubit>().addPengukuran(
                      tglPengukuran: selectedTglPengukuranString,
                      idBalita: selectedIdBalita,
                      caraPengukuran: selectedCaraPengukuran,
                      beratBadan: _beratBadanController.text,
                      tinggiBadan: _panjangBadanController.text,
                      lila: _lilaController.text,
                      lingkarKepala: _lingkarKepalaController.text,
                      selectedAsi: selectedAsi,
                      pemberianVitA: selectedPemberianVitA,
                      jumlahPemberian: _jumlahPemberianController.text,
                      pittingEdema: selectedPittingEdema,
                      derajat: selectedDerajat,
                      kelasIbuBalita: selectedKelasIbuBalita,
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
