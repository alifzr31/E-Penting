import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/measurement_type.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/create_measurement/widgets/create_measurement_form.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CreateMeasurementBody extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateMeasurementBody> createState() => _CreateMeasurementBodyState();
}

class _CreateMeasurementBodyState extends State<CreateMeasurementBody> {
  final _formKey = GlobalKey<FormState>();
  final _measurementDateController = TextEditingController();
  DateTime? _selectedMeasurementDate;
  int? _selectedToddlerId;
  final _toddlerNameController = TextEditingController();
  final _toddlerNikController = TextEditingController();
  final _toddlerBornDateController = TextEditingController();
  MeasurementType _selectedMeasurementType = .stand;
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _lilaController = TextEditingController();
  final _headCircumferenceController = TextEditingController();
  final List<int> _selectedAsiMonths = [];
  Boolean? _selectedGivenVitA;
  final _givenVitANumberController = TextEditingController();
  Boolean? _selectedPittingEdema;
  int? _selectedDegrees;
  Boolean? _selectedMotherToddlerClass;
  Boolean? _selectedMbg;

  @override
  void dispose() {
    _measurementDateController.dispose();
    _toddlerNameController.dispose();
    _toddlerNikController.dispose();
    _toddlerBornDateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _lilaController.dispose();
    _headCircumferenceController.dispose();
    _givenVitANumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeasurementCubit, MeasurementState>(
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
              title: 'Tambah Pengukuran Berhasil',
              description: state.formResponseData?['message'],
            );
            Navigator.pop(context, true);
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Tambah Pengukuran Gagal',
              description: state.formErrorMessage,
            );
          default:
            return;
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
                    child: CreateMeasurementForm(
                      formKey: _formKey,
                      measurementDateController: _measurementDateController,
                      selectedMeasurementDate: _selectedMeasurementDate,
                      onSelectedMeasurementDate: (date) {
                        _selectedMeasurementDate = date;
                        _measurementDateController.text = date.dayMonthYear();

                        setState(() {});
                      },
                      toddlerNameController: _toddlerNameController,
                      selectedToddlerId: _selectedToddlerId,
                      onSelectedToddlerName: (value) {
                        _selectedToddlerId = value.id ?? 0;
                        _toddlerNameController.text = value.namaAnak ?? '';
                        _toddlerNikController.text = value.nikAnak ?? '';
                        _toddlerBornDateController.text =
                            value.tanggalLahir?.dayMonthYear() ?? '';

                        setState(() {});
                      },
                      toddlerNikController: _toddlerNikController,
                      toddlerBornDateController: _toddlerBornDateController,
                      selectedMeasurementType: _selectedMeasurementType,
                      onSelectedMeasurementType: (value) {
                        setState(() {
                          _selectedMeasurementType = value;
                        });
                      },
                      weightController: _weightController,
                      heightController: _heightController,
                      lilaController: _lilaController,
                      headCircumferenceController: _headCircumferenceController,
                      selectedAsiMonths: _selectedAsiMonths,
                      onSelectedAsiMonths: (value) {
                        _selectedAsiMonths.clear();
                        _selectedAsiMonths.addAll(value);
                        setState(() {});
                      },
                      selectedGivenVitA: _selectedGivenVitA,
                      onSelectedGivenVitA: (value) {
                        setState(() {
                          _selectedGivenVitA = value;
                        });

                        if (_selectedGivenVitA != null &&
                            _selectedGivenVitA == .no) {
                          _givenVitANumberController.clear();
                        }
                      },
                      givenVitANumberController: _givenVitANumberController,
                      selectedPittingEdema: _selectedPittingEdema,
                      onSelectedPittingEdema: (value) {
                        _selectedPittingEdema = value;

                        if (_selectedPittingEdema != null &&
                            _selectedPittingEdema == .no) {
                          _selectedDegrees = null;
                        }

                        setState(() {});
                      },
                      selectedDegrees: _selectedDegrees,
                      onSelectedDegrees: (value) {
                        setState(() {
                          _selectedDegrees = value;
                        });
                      },
                      selectedMotherToddlerClass: _selectedMotherToddlerClass,
                      onSelectedMotherToddlerClass: (value) {
                        setState(() {
                          _selectedMotherToddlerClass = value;
                        });
                      },
                      selectedMbg: _selectedMbg,
                      onSelectedMbg: (value) {
                        setState(() {
                          _selectedMbg = value;
                        });
                      },
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
                    context.read<MeasurementCubit>().createMeasurement(
                      toddlerId: _selectedToddlerId,
                      measurementDate: _selectedMeasurementDate,
                      measurementType: _selectedMeasurementType.label
                          .toLowerCase(),
                      headCircumference: _headCircumferenceController.text,
                      lila: _lilaController.text,
                      height: _heightController.text,
                      weight: _weightController.text,
                      asiMonth0: Boolean.fromBool(
                        _selectedAsiMonths.contains(0),
                      ).valueString,
                      asiMonth1: Boolean.fromBool(
                        _selectedAsiMonths.contains(1),
                      ).valueString,
                      asiMonth2: Boolean.fromBool(
                        _selectedAsiMonths.contains(2),
                      ).valueString,
                      asiMonth3: Boolean.fromBool(
                        _selectedAsiMonths.contains(3),
                      ).valueString,
                      asiMonth4: Boolean.fromBool(
                        _selectedAsiMonths.contains(4),
                      ).valueString,
                      asiMonth5: Boolean.fromBool(
                        _selectedAsiMonths.contains(5),
                      ).valueString,
                      asiMonth6: Boolean.fromBool(
                        _selectedAsiMonths.contains(6),
                      ).valueString,
                      givenVitA: _selectedGivenVitA?.valueString,
                      givenVitANumber: _givenVitANumberController.text,
                      pittingEdema: _selectedPittingEdema?.valueBool,
                      degrees: _selectedDegrees,
                      motherToddlerClass:
                          _selectedMotherToddlerClass?.valueBool,
                      mbg: _selectedMbg?.valueBool,
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
