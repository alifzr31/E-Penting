import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/views/aktivasi_akun/widgets/aktivasiakun_header.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AktivasiAkunPage extends StatefulWidget {
  const AktivasiAkunPage({super.key});

  static const String routeName = '/aktivasiAkun';

  @override
  State<AktivasiAkunPage> createState() => _AktivasiAkunPageState();
}

class _AktivasiAkunPageState extends State<AktivasiAkunPage> {
  int currentStep = 0;
  List<Step> _getSteps() {
    return [
      Step(
        title: Text(
          'Cari NIK',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Masukkan NIK anda (Ayah dan Ibu)',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600),
        ),
        content: Container(),
        // content: firstStepContent(
        //   showGenderValidate: showGenderValidate,
        //   genderController: _genderController,
        //   onSelected: (value, index, isSelected) {
        //     setState(() {
        //       _selectedGender = value;
        //     });
        //   },
        // ),
        // isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          'Aktivasi Akun',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Masukkan usia balita anda dalam satuan bulan',
          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600),
        ),
        content: Container(),
        // content: secondStepContent(
        //   ageFormKey: ageFormKey,
        //   ageController: _ageController,
        // ),
        // isActive: _currentStep >= 1,
      ),
    ];
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
                    const AktivasiAkunHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Material(
                        color: Colors.white,
                        elevation: 1,
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Stepper(
                            currentStep: currentStep,
                            stepIconBuilder: (stepIndex, stepState) {
                              return CircleAvatar(
                                backgroundColor:
                                    currentStep >= stepIndex
                                        ? AppColors.blueColor
                                        : Colors.grey.shade500,
                                child: Center(
                                  child: Text(
                                    (stepIndex + 1).toString(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            margin: EdgeInsets.zero,
                            connectorThickness: 2,
                            connectorColor: WidgetStateColor.resolveWith((
                              states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return AppColors.blueColor;
                              }

                              return Colors.grey.shade400;
                            }),
                            stepIconMargin: const EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                            onStepContinue: () {},
                            onStepCancel: () {},
                            steps: _getSteps(),
                            controlsBuilder: (context, details) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (currentStep > 0 && currentStep < 4)
                                    BaseTextButton(
                                      text: 'Kembali',
                                      size: 12.sp,
                                      color: AppColors.blueColor,
                                      onPressed: details.onStepCancel,
                                    ),
                                  if (currentStep < 4)
                                    SizedBox(
                                      height: 30.h,
                                      child: BaseButton(
                                        bgColor: AppColors.blueColor,
                                        fgColor: Colors.white,
                                        label: 'Selanjutnya',
                                        onPressed: details.onStepContinue,
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
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
