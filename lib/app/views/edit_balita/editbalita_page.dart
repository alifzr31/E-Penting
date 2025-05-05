import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/balita/balita_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/edit_balita/widgets/editbalita_form.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

class EditBalitaPage extends StatefulWidget {
  const EditBalitaPage({required this.balitaId, super.key});

  final int balitaId;

  static const String routeName = '/editBalita';

  @override
  State<EditBalitaPage> createState() => _EditBalitaPageState();
}

class _EditBalitaPageState extends State<EditBalitaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nikAnakController = TextEditingController();
  final _noKkController = TextEditingController();
  final _namaBalitaController = TextEditingController();
  final _tglLahirController = TextEditingController();
  DateTime? selectedTglLahir;
  String? selectedTglLahirString;
  final _jenisKelaminController = GroupButtonController();
  String? selectedJenisKelamin;
  bool showJenisKelaminValidate = false;
  final _anakKeController = TextEditingController();
  final _beratLahirController = TextEditingController();
  final _panjangLahirController = TextEditingController();
  final _lingkarKepalaController = TextEditingController();
  final _usiaKehamilanController = TextEditingController();
  final _kiaBayiKecilController = GroupButtonController();
  bool? selectedKiaBayiKecil;
  bool showKiaBayiKecilValidate = false;
  final _bukuKiaController = GroupButtonController();
  int? selectedBukuKia;
  bool showBukuKiaValidate = false;
  final _imdController = GroupButtonController();
  int? selectedImd;
  bool showImdValidate = false;
  final _nikOrtuController = TextEditingController();
  final _namaOrtuController = TextEditingController();
  final _noTelpOrtuController = TextEditingController();
  final _alamatController = TextEditingController();
  final _rtController = TextEditingController();
  final _rwController = TextEditingController();
  final _pendudukBandungController = GroupButtonController();
  int? selectedPendudukBandung;
  bool showPendudukBandungValidate = false;
  final _kecamatanController = TextEditingController();
  final _kelurahanController = TextEditingController();
  final _puskesmasController = TextEditingController();

  void _loadDetailData() {
    context.loaderOverlay.show();

    context.read<BalitaCubit>().fetchDetailBalita(balitaId: widget.balitaId);
  }

  void _initFormData(Balita? detailBalita) {
    _nikAnakController.text = detailBalita?.nikAnak ?? '';
    _noKkController.text = detailBalita?.noKk ?? '';
    _namaBalitaController.text = detailBalita?.namaAnak ?? '';
    setState(() {
      selectedTglLahirString = DateFormat(
        'yyyy-MM-dd',
      ).format(detailBalita?.tanggalLahir ?? DateTime(0000));
      selectedTglLahir = DateFormat(
        'yyyy-MM-dd',
      ).parse(selectedTglLahirString ?? '');
    });
    _tglLahirController.text = AppHelpers.dayMonthYearFormat(
      detailBalita?.tanggalLahir ?? DateTime(0000),
    );
    _jenisKelaminController.selectIndex(
      detailBalita?.jenisKelamin == 'Laki-laki' ? 0 : 1,
    );
    setState(() {
      selectedJenisKelamin = detailBalita?.jenisKelamin;
    });
    _anakKeController.text = detailBalita?.anakKe?.toString() ?? '';
    _beratLahirController.text = AppHelpers.formatDoubleToString(
      detailBalita?.beratLahir ?? 0,
    );
    _panjangLahirController.text = AppHelpers.formatDoubleToString(
      detailBalita?.tinggi ?? 0,
    );
    _lingkarKepalaController.text =
        detailBalita?.lingkarKepalaLahir == null
            ? ''
            : AppHelpers.formatDoubleToString(
              detailBalita?.lingkarKepalaLahir ?? 0,
            );
    _usiaKehamilanController.text =
        detailBalita?.usiaKehamilan?.toString() ?? '';
    _kiaBayiKecilController.selectIndex(
      detailBalita?.kiaBayiKecil == 1 ? 0 : 1,
    );
    setState(() {
      selectedKiaBayiKecil = detailBalita?.kiaBayiKecil == 1 ? true : false;
    });
    _bukuKiaController.selectIndex(detailBalita?.kia == 1 ? 0 : 1);
    setState(() {
      selectedBukuKia = detailBalita?.kia;
    });
    _imdController.selectIndex(detailBalita?.imd == 1 ? 0 : 1);
    setState(() {
      selectedImd = detailBalita?.imd;
    });
    _nikOrtuController.text = detailBalita?.nikAyah ?? '';
    _namaOrtuController.text = detailBalita?.namaAyah ?? '';
    _noTelpOrtuController.text = detailBalita?.nomorTelepon ?? '';
    _alamatController.text = detailBalita?.alamat ?? '';
    _rtController.text = detailBalita?.rt ?? '';
    _rwController.text = detailBalita?.rw ?? '';
    _pendudukBandungController.selectIndex(
      detailBalita?.pendudukKotaBandung == 1 ? 0 : 1,
    );
    setState(() {
      selectedPendudukBandung = detailBalita?.pendudukKotaBandung;
    });
    _kecamatanController.text =
        context.read<AuthCubit>().state.profile?.namaKecamatan ?? '';
    _kelurahanController.text =
        context.read<AuthCubit>().state.profile?.namaKelurahan ?? '';
    _puskesmasController.text =
        context.read<AuthCubit>().state.profile?.namaPuskesmas ?? '';
  }

  @override
  void initState() {
    _loadDetailData();
    super.initState();
  }

  @override
  void dispose() {
    _nikAnakController.dispose();
    _noKkController.dispose();
    _namaBalitaController.dispose();
    _tglLahirController.dispose();
    _jenisKelaminController.dispose();
    _anakKeController.dispose();
    _beratLahirController.dispose();
    _panjangLahirController.dispose();
    _lingkarKepalaController.dispose();
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
    _kecamatanController.dispose();
    _kelurahanController.dispose();
    _puskesmasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<BalitaCubit>().resetEditFormState();
      },
      child: BlocListener<BalitaCubit, BalitaState>(
        listenWhen:
            (previous, current) =>
                previous.detailStatus != current.detailStatus,
        listener: (context, state) {
          if (state.detailStatus == DetailStatus.success) {
            context.loaderOverlay.hide();
            _initFormData(state.detailBalita);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            title: Text(
              'Edit Balita',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
          ),
          body: ListView(
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
                    child: EditBalitaForm(
                      formKey: _formKey,
                      nikAnakController: _nikAnakController,
                      noKkController: _noKkController,
                      namaBalitaController: _namaBalitaController,
                      tglLahirController: _tglLahirController,
                      selectedTglLahir: selectedTglLahir,
                      onConfirmTglLahir: (date) {
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
                      jenisKelaminController: _jenisKelaminController,
                      onSelectedJenisKelamin: (value, index, isSelected) {
                        setState(() {
                          selectedJenisKelamin = value;
                        });
                      },
                      showJenisKelaminValidate: showJenisKelaminValidate,
                      anakKeController: _anakKeController,
                      beratLahirController: _beratLahirController,
                      panjangLahirController: _panjangLahirController,
                      lingkarKepalaController: _lingkarKepalaController,
                      usiaKehamilanController: _usiaKehamilanController,
                      kiaBayiKecilController: _kiaBayiKecilController,
                      onSelectedKiaBayiKecil: (value, index, isSelected) {
                        setState(() {
                          selectedKiaBayiKecil = value;
                        });
                      },
                      showKiaBayiKecilValidate: showKiaBayiKecilValidate,
                      bukuKiaController: _bukuKiaController,
                      onSelectedBukuKia: (value, index, isSelected) {
                        setState(() {
                          selectedBukuKia = value;
                        });
                      },
                      showBukuKiaValidate: showBukuKiaValidate,
                      imdController: _imdController,
                      onSelectedImd: (value, index, isSelected) {
                        setState(() {
                          selectedImd = value;
                        });
                      },
                      showImdValidate: showImdValidate,
                      nikOrtuController: _nikOrtuController,
                      namaOrtuController: _namaOrtuController,
                      noTelpOrtuController: _noTelpOrtuController,
                      alamatController: _alamatController,
                      rtController: _rtController,
                      rwController: _rwController,
                      pendudukBandungController: _pendudukBandungController,
                      onSelectedPendudukBandung: (value, index, isSelected) {
                        setState(() {
                          selectedPendudukBandung = value;
                        });
                      },
                      showPendudukBandungValidate: showPendudukBandungValidate,
                      kecamatanController: _kecamatanController,
                      kelurahanController: _kelurahanController,
                      puskesmasController: _puskesmasController,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocListener<BalitaCubit, BalitaState>(
                listenWhen:
                    (previous, current) =>
                        previous.formStatus != current.formStatus,
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
                      title: 'Edit Balita Berhasil',
                      description:
                          'Data balita dengan nama ${state.detailBalita?.namaAnak} berhasil diedit dan disimpan',
                    );
                    context.read<BalitaCubit>().resetEditFormState();
                    context.read<DashboardCubit>().refetchLatestBalita();
                    context.read<BalitaCubit>().refetchAllBalita();
                  }

                  if (state.formStatus == FormStatus.error) {
                    context.loaderOverlay.hide();
                    showCustomToast(
                      context,
                      type: ToastificationType.error,
                      title: 'Edit Balita Gagal',
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
                          showJenisKelaminValidate =
                              selectedJenisKelamin == null ? true : false;
                          showKiaBayiKecilValidate =
                              selectedKiaBayiKecil == null ? true : false;
                          showBukuKiaValidate =
                              selectedBukuKia == null ? true : false;
                          showImdValidate = selectedImd == null ? true : false;
                          showPendudukBandungValidate =
                              selectedPendudukBandung == null ? true : false;
                        });

                        if (selectedJenisKelamin != null &&
                            selectedKiaBayiKecil != null &&
                            selectedBukuKia != null &&
                            selectedImd != null &&
                            selectedPendudukBandung != null) {
                          context.read<BalitaCubit>().updateBalita(
                            balitaId: widget.balitaId,
                            nikAnak: _nikAnakController.text,
                            noKk: _noKkController.text,
                            namaAnak: _namaBalitaController.text,
                            tglLahir: selectedTglLahirString,
                            jenisKelamin: selectedJenisKelamin,
                            anakKe: _anakKeController.text,
                            beratLahir: _beratLahirController.text,
                            tinggiLahir: _panjangLahirController.text,
                            lingkarKepala: _lingkarKepalaController.text,
                            usiaKehamilan: _usiaKehamilanController.text,
                            kiaBayiKecil: selectedKiaBayiKecil,
                            bukuKia: selectedBukuKia,
                            imd: selectedImd,
                            nikOrtu: _nikOrtuController.text,
                            namaOrtu: _namaOrtuController.text,
                            noTelpOrtu: _noTelpOrtuController.text,
                            alamat: _alamatController.text,
                            rt: _rtController.text,
                            rw: _rwController.text,
                            pendudukBandung: selectedPendudukBandung,
                            idKecamatan:
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .profile
                                    ?.kecamatan,
                            idKelurahan:
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .profile
                                    ?.kelurahan,
                            idPuskesmas:
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .profile
                                    ?.puskesmas,
                            idPosyandu:
                                context
                                    .read<AuthCubit>()
                                    .state
                                    .profile
                                    ?.posyandu,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
