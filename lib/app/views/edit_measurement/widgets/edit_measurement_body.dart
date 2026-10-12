import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/models/measurement_detail.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/measurement_type.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/edit_measurement/widgets/edit_measurement_form.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class EditMeasurementBody extends StatefulWidget {
  const new({required this.measurementId, super.key});

  final int measurementId;

  @override
  State<EditMeasurementBody> createState() => _EditMeasurementBodyState();
}

class _EditMeasurementBodyState extends State<EditMeasurementBody> {
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

  Future<void> _initMeasurementDetailData() async {
    final measurementId = widget.measurementId;
    final measurementCubit = context.read<MeasurementCubit>();

    context.loaderOverlay.show();

    await measurementCubit
        .fetchMeasurementDetail(measurementId: measurementId)
        .then((_) {
          final measurementDetailStatus =
              measurementCubit.state.measurementDetailStatus;

          if (!mounted) return;

          switch (measurementDetailStatus) {
            case .error:
              showCustomToast(
                context,
                type: .error,
                title: 'Ambil Data Balita Gagal',
                description:
                    measurementCubit.state.measurementDetailErrorMessage,
              );
              return;
            case .success:
              final measurementDetail =
                  measurementCubit.state.measurementDetail;

              _onFillingFormField(measurementDetail);
            default:
              return;
          }

          context.loaderOverlay.hide();
        });
  }

  void _onFillingFormField(MeasurementDetail? measurementDetail) {
    if (measurementDetail == null) return;

    _measurementDateController.text =
        measurementDetail.penimbangan?.tanggalUkur?.dayMonthYear() ?? '';
    _selectedMeasurementDate = measurementDetail.penimbangan?.tanggalUkur;
    _selectedToddlerId = measurementDetail.toddlerId;
    _toddlerNameController.text = measurementDetail.toddlerName ?? '';
    _toddlerNikController.text = measurementDetail.toddlerNik ?? '';
    _toddlerBornDateController.text =
        measurementDetail.toddlerBornDate?.dayMonthYear() ?? '';
    _selectedMeasurementType = MeasurementType.fromString(
      measurementDetail.penimbangan?.caraUkur,
    );
    _weightController.text =
        measurementDetail.penimbangan?.berat?.toStringAsPrecision(2) ?? '';
    _heightController.text =
        measurementDetail.penimbangan?.tinggi?.toStringAsPrecision(2) ?? '';
    _lilaController.text =
        measurementDetail.penimbangan?.lila?.toStringAsPrecision(2) ?? '';
    _headCircumferenceController.text =
        measurementDetail.penimbangan?.lingkarKepala?.toStringAsPrecision(2) ??
        '';

    _selectedAsiMonths.clear();
    final asiMonths = [
      measurementDetail.penimbangan?.asiBulan0,
      measurementDetail.penimbangan?.asiBulan1,
      measurementDetail.penimbangan?.asiBulan2,
      measurementDetail.penimbangan?.asiBulan3,
      measurementDetail.penimbangan?.asiBulan4,
      measurementDetail.penimbangan?.asiBulan5,
      measurementDetail.penimbangan?.asiBulan6,
    ];
    for (var i = 0; i < asiMonths.length; i++) {
      final isYes = Boolean.fromString(asiMonths[i]).valueBool;

      if (isYes) {
        _selectedAsiMonths.add(i);
      }
    }

    _selectedGivenVitA = Boolean.fromString(
      measurementDetail.penimbangan?.vitaminA,
    );
    _givenVitANumberController.text =
        measurementDetail.penimbangan?.pemberianKe ?? '';
    _selectedPittingEdema =
        (measurementDetail.penimbangan?.pittingEdema ?? 0) < 4 ? .yes : .no;
    _selectedDegrees = (measurementDetail.penimbangan?.pittingEdema ?? 0) < 4
        ? measurementDetail.penimbangan?.pittingEdema
        : null;
    _selectedMotherToddlerClass = Boolean.fromNumber(
      measurementDetail.penimbangan?.kelasIbuBalita,
    );
    _selectedMbg = Boolean.fromNumber(measurementDetail.penimbangan?.mbg);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initMeasurementDetailData();
  }

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
                    child: EditMeasurementForm(
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
                    context.read<MeasurementCubit>().editMeasurement(
                      measurementId: widget.measurementId,
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
