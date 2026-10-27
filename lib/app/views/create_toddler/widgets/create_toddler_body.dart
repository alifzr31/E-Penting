import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/utils/helpers/nik_helper.dart';
import 'package:e_penting/app/views/create_toddler/widgets/create_toddler_form.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CreateToddlerBody extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateToddlerBody> createState() => _CreateToddlerBodyState();
}

class _CreateToddlerBodyState extends State<CreateToddlerBody> {
  final _formKey = GlobalKey<FormState>();
  Boolean _selectedNewToddler = Boolean.yes;
  final _toddlerNikController = TextEditingController();
  final _toddlerNoKkController = TextEditingController();
  int? _selectedToddlerId;
  final _toddlerFullNameController = TextEditingController();
  DateTime? _selectedBornDate;
  final _bornDateController = TextEditingController();
  Gender? _selectedGender;
  final _toddlerNumberController = TextEditingController();
  final _toddlerWeightController = TextEditingController();
  final _toddlerHeightController = TextEditingController();
  final _toddlerHeadCircumferenceController = TextEditingController();
  final _gestationalAgeController = TextEditingController();
  Boolean? _selectedKiaBayiKecil;
  Boolean? _selectedHasKiaBook;
  Boolean? _selectedImd;
  final _parentNikController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _parentPhoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final List<String> _rts = List.generate(99, (index) {
    return (index + 1).toString().padLeft(3, '0');
  });
  final _selectedRt = ValueNotifier<String?>(null);
  final List<String> _rws = List.generate(99, (index) {
    return (index + 1).toString().padLeft(3, '0');
  });
  final _selectedRw = ValueNotifier<String?>(null);
  Boolean? _selectedBandungResident;
  final _districtNameController = TextEditingController();
  int? _selectedDistrictId;
  final _subDistrictNameController = TextEditingController();
  int? _selectedSubDistrictId;
  final _healthFacilityNameController = TextEditingController();
  int? _selectedHealthFacilityId;
  int? _selectedHealthPostId;
  final _beforeDistrictNameController = TextEditingController();
  final _beforeSubDistrictNameController = TextEditingController();
  final _beforeHealthFacilityNameController = TextEditingController();

  void _initRegion() {
    final authState = context.read<AuthCubit>().state;

    _districtNameController.text = authState.profile?.namaKecamatan ?? '';
    _selectedDistrictId = authState.profile?.kecamatan;
    _subDistrictNameController.text = authState.profile?.namaKelurahan ?? '';
    _selectedSubDistrictId = authState.profile?.kelurahan;
    _healthFacilityNameController.text = authState.profile?.namaPuskesmas ?? '';
    _selectedHealthFacilityId = authState.profile?.puskesmas;
    _selectedHealthPostId = authState.profile?.posyandu;
    setState(() {});
  }

  void _clearAllForm() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
      _formKey.currentState?.reset();
    });

    _toddlerNikController.clear();
    _toddlerNoKkController.clear();
    _selectedToddlerId = null;
    _toddlerFullNameController.clear();
    _selectedBornDate = null;
    _bornDateController.clear();
    _selectedGender = null;
    _toddlerNumberController.clear();
    _toddlerWeightController.clear();
    _toddlerHeightController.clear();
    _toddlerHeadCircumferenceController.clear();
    _gestationalAgeController.clear();
    _selectedKiaBayiKecil = null;
    _selectedHasKiaBook = null;
    _selectedImd = null;
    _parentNikController.clear();
    _parentNameController.clear();
    _parentPhoneNumberController.clear();
    _addressController.clear();
    _selectedRt.value = null;
    _selectedRw.value = null;
    _selectedBandungResident = null;
    _beforeDistrictNameController.clear();
    _beforeSubDistrictNameController.clear();
    _beforeHealthFacilityNameController.clear();

    setState(() {});
  }

  void _onSelctedToddlerFullName(Toddler toddler) {
    _toddlerNikController.text = toddler.nikAnak ?? '';
    _toddlerNoKkController.text = toddler.noKk ?? '';
    _selectedToddlerId = toddler.id;
    _toddlerFullNameController.text = toddler.namaAnak ?? '';
    _selectedBornDate = toddler.tanggalLahir;
    _bornDateController.text = toddler.tanggalLahir?.dayMonthYear() ?? '';
    _selectedGender = Gender.fromApi(toddler.jenisKelamin);
    _toddlerNumberController.text = toddler.anakKe?.toString() ?? '';
    _toddlerWeightController.text = toddler.beratLahir?.toString() ?? '';
    _toddlerHeightController.text = toddler.tinggi?.toString() ?? '';
    _toddlerHeadCircumferenceController.text =
        toddler.lingkarKepalaLahir?.toString() ?? '';
    _gestationalAgeController.text = toddler.usiaKehamilan?.toString() ?? '';
    _selectedKiaBayiKecil = toddler.kiaBayiKecil == null
        ? null
        : Boolean.fromBool(toddler.kiaBayiKecil);
    _selectedHasKiaBook = toddler.kia == null
        ? null
        : Boolean.fromBool(toddler.kia);
    _selectedImd = toddler.imd == null ? null : Boolean.fromBool(toddler.imd);
    _parentNikController.text = toddler.nikAyah ?? '';
    _parentNameController.text = toddler.namaAyah ?? '';
    _parentPhoneNumberController.text = toddler.nomorTelepon ?? '';
    _addressController.text = toddler.alamat ?? '';
    _selectedRt.value = toddler.rt?.formatRt(_rts);
    _selectedRw.value = toddler.rw?.formatRw(_rts);
    _selectedBandungResident = Boolean.fromBool(toddler.pendudukKotaBandung);
    _beforeDistrictNameController.text = toddler.namaKecamatan ?? '';
    _beforeSubDistrictNameController.text = toddler.namaKelurahan ?? '';
    _beforeHealthFacilityNameController.text = toddler.namaPuskesmas ?? '';

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initRegion();
  }

  @override
  void dispose() {
    _toddlerNikController.dispose();
    _toddlerNoKkController.dispose();
    _toddlerFullNameController.dispose();
    _bornDateController.dispose();
    _toddlerNumberController.dispose();
    _toddlerWeightController.dispose();
    _toddlerHeightController.dispose();
    _toddlerHeadCircumferenceController.dispose();
    _gestationalAgeController.dispose();
    _parentNikController.dispose();
    _parentNameController.dispose();
    _parentPhoneNumberController.dispose();
    _addressController.dispose();
    _selectedRt.dispose();
    _selectedRw.dispose();
    _districtNameController.dispose();
    _subDistrictNameController.dispose();
    _healthFacilityNameController.dispose();
    _beforeDistrictNameController.dispose();
    _beforeSubDistrictNameController.dispose();
    _beforeHealthFacilityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ToddlerCubit, ToddlerState>(
          listenWhen: (previous, current) {
            return previous.checkToddlerNikStatus !=
                current.checkToddlerNikStatus;
          },
          listener: (context, state) {
            switch (state.checkToddlerNikStatus) {
              case .loading:
                context.loaderOverlay.show();
              case .success:
                context.read<ToddlerCubit>().createToddler(
                  newToddler: _selectedNewToddler.valueBool,
                  toddlerNik: _toddlerNikController.text,
                  toddlerNoKk: _toddlerNoKkController.text,
                  toddlerId: _selectedToddlerId,
                  toddlerName: _toddlerFullNameController.text,
                  toddlerBornDate: _selectedBornDate,
                  toddlerGender: _selectedGender?.label,
                  toddlerNumber: _toddlerNumberController.text,
                  toddlerWeight: _toddlerWeightController.text,
                  toddlerHeight: _toddlerHeightController.text,
                  toddlerHeadCircumference:
                      _toddlerHeadCircumferenceController.text,
                  gestationalAge: _gestationalAgeController.text,
                  kiaBayiKecil: _selectedKiaBayiKecil?.valueBool,
                  hasKiaBook: _selectedHasKiaBook?.valueNumber,
                  imd: _selectedImd?.valueNumber,
                  parentNik: _parentNikController.text,
                  parentName: _parentNameController.text,
                  parentPhoneNumber: _parentPhoneNumberController.text,
                  address: _addressController.text,
                  rt: _selectedRt.value,
                  rw: _selectedRw.value,
                  isBandungResident: _selectedBandungResident?.valueNumber,
                  districtId: _selectedDistrictId,
                  subDistrictId: _selectedSubDistrictId,
                  healthFacilityId: _selectedHealthFacilityId,
                  healthPostId: _selectedHealthPostId,
                );
              case .error:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .error,
                  title: 'Tambah Balita Gagal',
                  description: state.checkToddlerNikErrorMessage,
                );
              default:
                return;
            }
          },
        ),
        BlocListener<ToddlerCubit, ToddlerState>(
          listenWhen: (previous, current) {
            return previous.formStatus != current.formStatus;
          },
          listener: (context, state) {
            switch (state.formStatus) {
              case .success:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .success,
                  title: 'Tambah Balita Berhasil',
                  description: state.formResponseData?['message'],
                );
                Navigator.pop(context, true);
              case .error:
                context.loaderOverlay.hide();
                showCustomToast(
                  context,
                  type: .error,
                  title: 'Tambah Balita Gagal',
                  description: state.formErrorMessage,
                );
              default:
                return;
            }
          },
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const .only(top: 16, left: 16, right: 16, bottom: 6),
              child: SizedBox(
                width: .infinity,
                child: Material(
                  elevation: 1,
                  color: Colors.white,
                  clipBehavior: .antiAlias,
                  borderRadius: .circular(10),
                  child: Padding(
                    padding: const .all(16),
                    child: CreateToddlerForm(
                      formKey: _formKey,
                      selectedNewToddler: _selectedNewToddler,
                      onSelectedNewToddler: (value) {
                        setState(() {
                          _selectedNewToddler = value;
                        });

                        _clearAllForm();
                      },
                      onGenerateDummyNik: () {
                        final dummyNik = NikHelper.generateDummyNik();
                        _toddlerNikController.text = dummyNik;

                        setState(() {});
                      },
                      toddlerNikController: _toddlerNikController,
                      toddlerNoKkController: _toddlerNoKkController,
                      toddlerFullNameController: _toddlerFullNameController,
                      onSelectedToddlerFullName: _onSelctedToddlerFullName,
                      selectedBornDate: _selectedBornDate,
                      bornDateController: _bornDateController,
                      onSelectedBornDate: (date) {
                        _selectedBornDate = date;
                        _bornDateController.text =
                            _selectedBornDate?.dayMonthYear() ?? '';
                        setState(() {});
                      },
                      selectedGender: _selectedGender,
                      onSelectedGender: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                      toddlerNumberController: _toddlerNumberController,
                      toddlerWeightController: _toddlerWeightController,
                      toddlerHeightController: _toddlerHeightController,
                      toddlerHeadCircumferenceController:
                          _toddlerHeadCircumferenceController,
                      gestationalAgeController: _gestationalAgeController,
                      selectedKiaBayiKecil: _selectedKiaBayiKecil,
                      onSelectedKiaBayiKecil: (value) {
                        setState(() {
                          _selectedKiaBayiKecil = value;
                        });
                      },
                      selectedHasKiaBook: _selectedHasKiaBook,
                      onSelectedHasKiaBook: (value) {
                        setState(() {
                          _selectedHasKiaBook = value;
                        });
                      },
                      selectedImd: _selectedImd,
                      onSelectedImd: (value) {
                        setState(() {
                          _selectedImd = value;
                        });
                      },
                      parentNikController: _parentNikController,
                      parentNameController: _parentNameController,
                      parentPhoneNumberController: _parentPhoneNumberController,
                      addressController: _addressController,
                      rts: _rts,
                      selectedRt: _selectedRt,
                      onSelectedRt: (value) {
                        setState(() {
                          _selectedRt.value = value;
                        });
                      },
                      rws: _rws,
                      selectedRw: _selectedRw,
                      onSelectedRw: (value) {
                        setState(() {
                          _selectedRw.value = value;
                        });
                      },
                      selectedBandungResident: _selectedBandungResident,
                      onSelectedBandungResident: (value) {
                        setState(() {
                          _selectedBandungResident = value;
                        });
                      },
                      districtNameController: _districtNameController,
                      subDistrictNameController: _subDistrictNameController,
                      healthFacilityNameController:
                          _healthFacilityNameController,
                      beforeDistrictNameController:
                          _beforeDistrictNameController,
                      beforeSubDistrictNameController:
                          _beforeSubDistrictNameController,
                      beforeHealthFacilityNameController:
                          _beforeHealthFacilityNameController,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const .only(top: 10, left: 16, right: 16, bottom: 16),
              child: BaseButtonIcon(
                width: .infinity,
                icon: RemixIcon.save2Line,
                label: 'Simpan',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<ToddlerCubit>().checkToddlerNik(
                      nik: _toddlerNikController.text,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
