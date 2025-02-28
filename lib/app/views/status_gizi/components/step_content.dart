import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/utils/app_strings.dart';
import 'package:epenting/app/widgets/base_button.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:group_button/group_button.dart';
import 'package:loader_overlay/loader_overlay.dart';

Widget firstStepContent({
  required bool showGenderValidate,
  GroupButtonController? genderController,
  dynamic Function(String, int, bool)? onSelected,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showGenderValidate)
          Text(
            'Mohon pilih jenis kelamin balita anda',
            style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
          ),
        if (showGenderValidate) SizedBox(height: 10.h),
        GroupButton(
          controller: genderController,
          isRadio: true,
          buttons: ['Laki-laki', 'Perempuan'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? AppColors.blueColor
                              : Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Laki-Laki' : 'Perempuan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelected,
        ),
      ],
    ),
  );
}

Widget secondStepContent({
  required GlobalKey<FormState> ageFormKey,
  TextEditingController? ageController,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 15),
    child: Form(
      key: ageFormKey,
      child: BaseFormField(
        hint: 'Masukkan usia balita',
        controller: ageController,
        keyboardType: TextInputType.number,
        suffixIcon: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            'bulan',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Mohon masukkan usia balita';
          }

          return null;
        },
      ),
    ),
  );
}

Widget thirdStepContent({
  required bool showMeasureValidate,
  GroupButtonController? measureController,
  dynamic Function(String, int, bool)? onSelected,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showMeasureValidate)
          Text(
            'Mohon pilih cara pengukuran balita anda',
            style: TextStyle(fontSize: 12.sp, color: Colors.red.shade600),
          ),
        if (showMeasureValidate) SizedBox(height: 10.h),
        GroupButton(
          controller: measureController,
          isRadio: true,
          buttons: ['berdiri', 'terlentang'],
          buttonIndexedBuilder: (selected, index, context) {
            return Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? AppColors.blueColor
                              : Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    index == 0 ? 'Berdiri' : 'Terlentang',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          },
          onSelected: onSelected,
        ),
      ],
    ),
  );
}

Widget fourthStepContent({
  required GlobalKey<FormState> weightFormKey,
  TextEditingController? weightController,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '*Gunakan titik (.) untuk koma',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.h),
        Form(
          key: weightFormKey,
          child: BaseFormField(
            hint: 'Masukkan berat badan balita',
            controller: weightController,
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                'kg',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan berat badan balita';
              }

              return null;
            },
          ),
        ),
      ],
    ),
  );
}

Widget fifthStepContent({
  required GlobalKey<FormState> heightFormKey,
  TextEditingController? heightController,
  void Function()? onFinishStep,
  void Function()? onStepCancel,
  void Function()? onPressedRecheck,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '*Gunakan titik (.) untuk koma',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.h),
        Form(
          key: heightFormKey,
          child: BaseFormField(
            hint: 'Masukkan tinggi badan balita',
            controller: heightController,
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                'cm',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Mohon masukkan tinggi badan balita';
              }

              return null;
            },
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseTextButton(
              text: 'Kembali',
              size: 12.sp,
              color: AppColors.blueColor,
              onPressed: onStepCancel,
            ),
            BlocListener<StatusGiziCubit, StatusGiziState>(
              listenWhen:
                  (previous, current) =>
                      previous.dataStatus != current.dataStatus,
              listener: (context, state) {
                if (state.dataStatus == DataStatus.loading) {
                  context.loaderOverlay.show();
                }

                if (state.dataStatus == DataStatus.success) {
                  context.loaderOverlay.hide();

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: PopScope(
                            canPop: false,
                            child: Material(
                              color: Colors.white,
                              elevation: 1,
                              borderRadius: BorderRadius.circular(20.r),
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Status Gizi Balita Anda',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      height: 120.h,
                                      child: SvgPicture.asset(
                                        '${AppStrings.assetsImages}/baby.svg',
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Material(
                                      color: Colors.blue.shade100,
                                      shape: const StadiumBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 16,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(
                                                context,
                                              ).style.copyWith(fontSize: 10.sp),
                                              children: [
                                                TextSpan(
                                                  text: 'Tinggi badan balita: ',
                                                ),
                                                TextSpan(
                                                  text: state.classification,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Material(
                                      color: Colors.blue.shade100,
                                      shape: const StadiumBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 16,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(
                                                context,
                                              ).style.copyWith(fontSize: 10.sp),
                                              children: [
                                                TextSpan(
                                                  text: 'Berat badan balita: ',
                                                ),
                                                TextSpan(
                                                  text: state.weight,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Material(
                                      color: Colors.blue.shade100,
                                      shape: const StadiumBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 16,
                                        ),
                                        child: Center(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(
                                                context,
                                              ).style.copyWith(fontSize: 10.sp),
                                              children: [
                                                TextSpan(text: 'Gizi balita: '),
                                                TextSpan(
                                                  text: state.nutrition,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      height: 30.h,
                                      width: double.infinity,
                                      child: BaseButtonIcon(
                                        label: 'Cek Ulang',
                                        icon: Icons.refresh,
                                        bgColor: AppColors.orangeColor,
                                        fgColor: Colors.white,
                                        onPressed: onPressedRecheck,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state.dataStatus == DataStatus.error) {
                  context.loaderOverlay.hide();
                  if (kDebugMode) print(state.error);
                }
              },
              child: SizedBox(
                height: 30.h,
                child: BaseButton(
                  bgColor: AppColors.blueColor,
                  fgColor: Colors.white,
                  label: 'Submit',
                  onPressed: onFinishStep,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
