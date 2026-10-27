import 'package:e_penting/app/cubits/auth/auth_cubit.dart' hide Status;
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/views/edit_toddler/widgets/edit_toddler_form.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class EditToddlerBody extends StatefulWidget {
  const new({required this.toddlerId, super.key});

  final int toddlerId;

  @override
  State<EditToddlerBody> createState() => _EditToddlerBodyState();
}

class _EditToddlerBodyState extends State<EditToddlerBody> {
  final _formKey = GlobalKey<FormState>();
  final _toddlerNikController = TextEditingController();
  final _toddlerNoKkController = TextEditingController();
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

  Future<void> _initToddlerDetailData() async {
    final id = widget.toddlerId;
    final toddlerCubit = context.read<ToddlerCubit>();
    final authCubit = context.read<AuthCubit>();

    context.loaderOverlay.show();

    await toddlerCubit.fetchDetailToddler(id: id).then((_) {
      final toddlerDetailStatus = toddlerCubit.state.toddlerDetailStatus;
      final userProfile = authCubit.state.profile;

      if (!mounted) return;

      switch (toddlerDetailStatus) {
        case .error:
          showCustomToast(
            context,
            type: .error,
            title: 'Ambil Data Balita Gagal',
            description: toddlerCubit.state.toddlerDetailErrorMessage,
          );
          return;
        case .success:
          final toddlerDetail = toddlerCubit.state.toddlerDetail;

          _onFillingFormField(toddlerDetail, userProfile);
        default:
          return;
      }

      context.loaderOverlay.hide();
    });
  }

  void _onFillingFormField(Toddler? toddlerDetail, Profile? userProfile) {
    if (toddlerDetail == null || userProfile == null) return;

    _toddlerNikController.text = toddlerDetail.nikAnak ?? '';
    _toddlerNoKkController.text = toddlerDetail.noKk ?? '';
    _toddlerFullNameController.text = toddlerDetail.namaAnak ?? '';
    _selectedBornDate = toddlerDetail.tanggalLahir;
    _bornDateController.text = toddlerDetail.tanggalLahir?.dayMonthYear() ?? '';
    _selectedGender = Gender.fromApi(toddlerDetail.jenisKelamin);
    _toddlerNumberController.text = toddlerDetail.anakKe?.toString() ?? '';
    _toddlerWeightController.text = toddlerDetail.beratLahir?.toString() ?? '';
    _toddlerHeightController.text = toddlerDetail.tinggi?.toString() ?? '';
    _toddlerHeadCircumferenceController.text =
        toddlerDetail.lingkarKepalaLahir?.toString() ?? '';
    _gestationalAgeController.text =
        toddlerDetail.usiaKehamilan?.toString() ?? '';
    _selectedKiaBayiKecil = Boolean.fromBool(toddlerDetail.kiaBayiKecil);
    _selectedHasKiaBook = Boolean.fromBool(toddlerDetail.kia);
    _selectedImd = Boolean.fromBool(toddlerDetail.imd);
    _parentNikController.text = toddlerDetail.nikAyah ?? '';
    _parentNameController.text = toddlerDetail.namaAyah ?? '';
    _parentPhoneNumberController.text = toddlerDetail.nomorTelepon ?? '';
    _addressController.text = toddlerDetail.alamat ?? '';
    _selectedRt.value = toddlerDetail.rt?.formatRt(_rts);
    _selectedRw.value = toddlerDetail.rw?.formatRw(_rws);
    _selectedBandungResident = Boolean.fromBool(
      toddlerDetail.pendudukKotaBandung,
    );
    _districtNameController.text = userProfile.namaKecamatan ?? '';
    _selectedDistrictId = userProfile.kecamatan;
    _subDistrictNameController.text = userProfile.namaKelurahan ?? '';
    _selectedSubDistrictId = userProfile.kelurahan;
    _healthFacilityNameController.text = userProfile.namaPuskesmas ?? '';
    _selectedHealthFacilityId = userProfile.puskesmas;
    _selectedHealthPostId = userProfile.posyandu;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initToddlerDetailData();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToddlerCubit, ToddlerState>(
      listenWhen: (previous, current) {
        return previous.formStatus != current.formStatus;
      },
      listener: (context, state) {
        switch (state.formStatus) {
          case .loading:
            context.loaderOverlay.show();
          case .success:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .success,
              title: 'Edit Balita Berhasil',
              description: state.formResponseData?['message'],
            );
            Navigator.pop(context, true);
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Edit Balita Gagal',
              description: state.formErrorMessage,
            );
          default:
        }
      },
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
                    child: EditToddlerForm(
                      formKey: _formKey,
                      toddlerNikController: _toddlerNikController,
                      toddlerNoKkController: _toddlerNoKkController,
                      toddlerFullNameController: _toddlerFullNameController,
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
                icon: RemixIcon.save3Line,
                label: 'Simpan Data',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<ToddlerCubit>().editToddler(
                      toddlerId: widget.toddlerId,
                      toddlerNik: _toddlerNikController.text,
                      toddlerNoKk: _toddlerNoKkController.text,
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
