import 'package:e_penting/app/cubits/nutrition/nutrition_cubit.dart';
import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/consts/app_strings.dart';
import 'package:e_penting/app/utils/extensions/context_extension.dart';
import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:e_penting/app/utils/enums/measurement_type.dart';
import 'package:e_penting/app/utils/text_input_formatters/decimal_input_formatter.dart';
import 'package:e_penting/app/views/nutrition/widgets/nutrition_step_card.dart';
import 'package:e_penting/app/views/nutrition/widgets/nutrition_stepper.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NutritionView extends StatefulWidget {
  const new({super.key});

  @override
  State<NutritionView> createState() => _NutritionViewState();
}

class _NutritionViewState extends State<NutritionView> {
  int _currentStep = 0;

  final List<String> _stepLabels = [
    'Jenis\nKelamin',
    'Usia\nBalita',
    'Cara\nPengukuran',
    'Berat\nBalita',
    'Panjang\nBalita',
  ];

  String? _selectedGender;
  bool _isGenderNotValid = false;
  final _ageFormKey = GlobalKey<FormState>();
  final _monthAgeController = TextEditingController();
  String? _selectedMeasureType;
  bool _isMeasureTypeNotValid = false;
  final _weightFormKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _tallFormKey = GlobalKey<FormState>();
  final _tallController = TextEditingController();

  List<Map<String, dynamic>> _steps() {
    return [
      {
        'title': 'Jenis Kelamin',
        'subtitle': 'Pilih jenis kelamin balita anda',
        'content': RadioGroup<String>(
          groupValue: _selectedGender,
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              _selectedGender = value;
            });
          },
          child: Column(
            children: [
              ...Gender.filteredValues.map((e) {
                return Row(
                  children: [
                    Radio<String>(
                      value: e.label,
                      activeColor: AppColors.blueColor,
                      overlayColor: WidgetStatePropertyAll(
                        AppColors.blueColor.withValues(alpha: 0.1),
                      ),
                    ),
                    Flexible(child: Text(e.label)),
                  ],
                );
              }),
              if (_isGenderNotValid) ...[
                const SizedBox(height: 4),
                Text(
                  'Silahkan pilih jenis kelamin balita',
                  style: TextStyle(fontSize: 12, color: Colors.red.shade600),
                ),
              ],
            ],
          ),
        ),
      },
      {
        'title': 'Usia Balita',
        'subtitle': 'Masukkan usia balita anda dalam satuan bulan',
        'content': Form(
          key: _ageFormKey,
          child: BaseFormField(
            hint: 'Masukkan usia balita*',
            controller: _monthAgeController,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan usia balita dalam satuan bulan';
              }

              return null;
            },
          ),
        ),
      },
      {
        'title': 'Cara Pengukuran',
        'subtitle': 'Pilih cara pengukuran balita anda',
        'content': RadioGroup<String>(
          groupValue: _selectedMeasureType,
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              _selectedMeasureType = value;
            });
          },
          child: Column(
            children: [
              ...MeasurementType.filteredValues.map((e) {
                return Row(
                  children: [
                    Radio<String>(
                      value: e.label,
                      activeColor: AppColors.blueColor,
                      overlayColor: WidgetStatePropertyAll(
                        AppColors.blueColor.withValues(alpha: 0.1),
                      ),
                    ),
                    Flexible(child: Text(e.label)),
                  ],
                );
              }),
              if (_isMeasureTypeNotValid) ...[
                const SizedBox(height: 4),
                Text(
                  'Silahkan pilih jenis pengukuran',
                  style: TextStyle(fontSize: 12, color: Colors.red.shade600),
                ),
              ],
            ],
          ),
        ),
      },
      {
        'title': 'Berat Balita',
        'subtitle': 'Masukkan berat balita Anda pada kolom di bawah ini dalam satuan kilogram.\nGunakan titik (.) untuk koma',
        'content': Form(
          key: _weightFormKey,
          child: BaseFormField(
            hint: 'Masukkan berat balita*',
            controller: _weightController,
            keyboardType: const .numberWithOptions(decimal: true),
            inputFormatters: [DecimalInputFormatter()],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan berat balita dalam satuan kilogram';
              }

              return null;
            },
          ),
        ),
      },
      {
        'title': 'Panjang/Tinggi Balita',
        'subtitle': 'Masukkan panjang/tinggi balita Anda pada kolom di bawah ini dalam satuan centimeter.\nGunakan titik (.) untuk koma',
        'content': Form(
          key: _tallFormKey,
          child: BaseFormField(
            hint: 'Masukkan panjang/tinggi balita*',
            controller: _tallController,
            keyboardType: const .numberWithOptions(decimal: true),
            inputFormatters: [DecimalInputFormatter()],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan panjang/tinggi balita dalam satuan centimeter';
              }

              return null;
            },
          ),
        ),
      },
    ];
  }

  @override
  void dispose() {
    _monthAgeController.dispose();
    _weightController.dispose();
    _tallController.dispose();
    super.dispose();
  }

  void _nextStep() {
    bool isValid = false;

    switch (_currentStep) {
      case 0:
        isValid = _selectedGender != null;
        break;
      case 1:
        isValid = _ageFormKey.currentState?.validate() ?? false;
        break;
      case 2:
        isValid = _selectedMeasureType != null;
        break;
      case 3:
        isValid = _weightFormKey.currentState?.validate() ?? false;
        break;
      default:
        if (_tallFormKey.currentState?.validate() ?? false) {
          context.read<NutritionCubit>().fetchNutritionCheck(
            monthAge: _monthAgeController.text,
            tall: _tallController.text,
            weight: _weightController.text,
            measureType: _selectedMeasureType?.toLowerCase(),
            gender: _selectedGender,
          );
        }
        return;
    }

    setState(() {
      if (isValid) {
        _currentStep++;
        _isGenderNotValid = false;
        _isMeasureTypeNotValid = false;
      } else {
        if (_currentStep == 0) _isGenderNotValid = true;
        if (_currentStep == 2) _isMeasureTypeNotValid = true;
      }
    });
  }

  void _backStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _onRecheck() {
    if (!mounted) return;

    Navigator.pop(context);
    _selectedGender = null;
    _isGenderNotValid = false;
    _ageFormKey.currentState?.reset();
    _monthAgeController.clear();
    _selectedMeasureType = null;
    _isMeasureTypeNotValid = false;
    _weightFormKey.currentState?.reset();
    _weightController.clear();
    _tallFormKey.currentState?.reset();
    _tallController.clear();
    _currentStep = 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.deviceHeight,
          width: context.deviceWidth,
          child: Stack(
            children: [
              Positioned(
                bottom: -40,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    '${AppStrings.assetsImages}/bottom_statusgizi.svg',
                    fit: BoxFit.cover,
                    width: context.deviceWidth,
                  ),
                ),
              ),
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const .all(16),
                  child: Column(
                    children: [
                      NutritionStepper(
                        stepLabels: _stepLabels,
                        currentStep: _currentStep,
                      ),
                      const SizedBox(height: 32),
                      NutritionStepCard(
                        title: _steps()[_currentStep]['title'],
                        description: _steps()[_currentStep]['subtitle'],
                        content: _steps()[_currentStep]['content'],
                        onNext: _nextStep,
                        onBack: _backStep,
                        isFirstStep: _currentStep == 0,
                        isLastStep: _currentStep == _stepLabels.length - 1,
                        onRecheck: _onRecheck,
                      ),
                    ],
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
