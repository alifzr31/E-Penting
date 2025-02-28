import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/status_gizi/components/step_content.dart';
import 'package:epenting/app/views/status_gizi/widgets/statusgizi_header.dart';
import 'package:epenting/app/views/status_gizi/widgets/statusgizi_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';

class StatusGiziPage extends StatefulWidget {
  const StatusGiziPage({super.key});

  static const String routeName = '/statusGizi';

  @override
  State<StatusGiziPage> createState() => _StatusGiziPageState();
}

class _StatusGiziPageState extends State<StatusGiziPage> {
  int _currentStep = 0;
  bool showGenderValidate = false;
  final _genderController = GroupButtonController();
  String? _selectedGender;
  final ageFormKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  bool showMeasureValidate = false;
  final _measureController = GroupButtonController();
  String? _selectedMeasure;
  final weightFormKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final heightFormKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();

  List<Step> _getSteps() {
    return [
      Step(
        title: Text(
          'Jenis Kelamin',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Pilih jenis kelamin balita anda',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
        ),
        content: firstStepContent(
          showGenderValidate: showGenderValidate,
          genderController: _genderController,
          onSelected: (value, index, isSelected) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          'Usia Balita',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Masukkan usia balita anda dalam satuan bulan',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
        ),
        content: secondStepContent(
          ageFormKey: ageFormKey,
          ageController: _ageController,
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Cara Pengukuran',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Pilih cara pengukuran balita anda',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
        ),
        content: thirdStepContent(
          showMeasureValidate: showMeasureValidate,
          measureController: _measureController,
          onSelected: (value, index, isSelected) {
            setState(() {
              _selectedMeasure = value;
            });
          },
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text(
          'Berat Balita',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Masukkan berat badan balita anda dalam satuan kilogram',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
        ),
        content: fourthStepContent(
          weightFormKey: weightFormKey,
          weightController: _weightController,
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: Text(
          'Panjang Balita',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Masukkan tinggi badan balita anda dalam satuan cm',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500),
        ),
        content: fifthStepContent(
          heightFormKey: heightFormKey,
          heightController: _heightController,
          onFinishStep: _onFinishStep,
          onStepCancel: _onStepCancel,
          onPressedRecheck: () {
            heightFormKey.currentState?.reset();
            _heightController.clear();
            weightFormKey.currentState?.reset();
            _weightController.clear();
            _measureController.unselectAll();
            ageFormKey.currentState?.reset();
            _ageController.clear();
            _genderController.unselectAll();
            setState(() {
              _currentStep = 0;
            });
            Navigator.pop(context);
          },
        ),
        isActive: _currentStep >= 4,
      ),
    ];
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void _onStepContinueFirstStep() {
    if (_currentStep == 0 && _genderController.selectedIndex == null) {
      setState(() {
        showGenderValidate = true;
      });
    } else {
      setState(() {
        showGenderValidate = false;
        _currentStep += 1;
      });
    }
  }

  void _onStepContinueSecondStep() {
    if (_currentStep == 1 && (ageFormKey.currentState?.validate() ?? false)) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _onStepContinueThirdStep() {
    if (_currentStep == 2 && _measureController.selectedIndex == null) {
      setState(() {
        showMeasureValidate = true;
      });
    } else {
      setState(() {
        showMeasureValidate = false;
        _currentStep += 1;
      });
    }
  }

  void _onStepContinueFourthStep() {
    if (_currentStep == 3 &&
        (weightFormKey.currentState?.validate() ?? false)) {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _onFinishStep() async {
    if (_currentStep == 4 &&
        (heightFormKey.currentState?.validate() ?? false)) {
      context.read<StatusGiziCubit>().fetchData(
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        gender: _selectedGender,
        measure: _selectedMeasure,
      );
    }
  }

  @override
  void dispose() {
    _genderController.dispose();
    _ageController.dispose();
    _measureController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Stack(
            children: [
              Positioned(
                bottom: -40.h,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.1,
                  child: SvgPicture.asset(
                    '${AppStrings.assetsImages}/bottom_statusgizi.svg',
                    width: ScreenUtil().screenWidth,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    const StatusGiziHeader(),
                    StatusGiziStepper(
                      currentStep: _currentStep,
                      steps: _getSteps(),
                      onStepContinue:
                          _currentStep == 0
                              ? _onStepContinueFirstStep
                              : _currentStep == 1
                              ? _onStepContinueSecondStep
                              : _currentStep == 2
                              ? _onStepContinueThirdStep
                              : _onStepContinueFourthStep,
                      onStepCancel: _onStepCancel,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
