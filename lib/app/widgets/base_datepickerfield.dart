import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/widgets/base_formfield.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseDatePickerField extends StatelessWidget {
  const BaseDatePickerField({
    required this.pickerModel,
    this.hint,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.helperText,
    this.helperTextColor,
    this.onConfirmDate,
    super.key,
  });

  final picker.BasePickerModel pickerModel;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? helperText;
  final Color? helperTextColor;
  final dynamic Function(DateTime)? onConfirmDate;

  @override
  Widget build(BuildContext context) {
    return BaseFormField(
      controller: controller,
      hint: hint,
      helperText: helperText,
      helperTextColor: helperTextColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      focusNode: focusNode,
      validator: validator,
      readOnly: true,
      onTap: () {
        picker.DatePicker.showPicker(
          context,
          pickerModel: pickerModel,
          theme: picker.DatePickerTheme(
            itemStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Poppins'),
            cancelStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            doneStyle: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              color: AppColors.blueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          locale: picker.LocaleType.id,
          onConfirm: onConfirmDate,
        );
      },
    );
  }
}

class BaseDatePickerGroupField extends StatelessWidget {
  const BaseDatePickerGroupField({
    required this.label,
    required this.pickerModel,
    this.hint,
    this.mandatory = false,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.helperText,
    this.helperTextColor,
    this.onConfirmDate,
    super.key,
  });

  final String label;
  final picker.BasePickerModel pickerModel;
  final String? hint;
  final bool mandatory;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? helperText;
  final Color? helperTextColor;
  final dynamic Function(DateTime)? onConfirmDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child:
              mandatory
                  ? RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: label,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '*',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  )
                  : Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
        ),
        SizedBox(height: 2.h),
        BaseFormField(
          controller: controller,
          hint: hint,
          helperText: helperText,
          helperTextColor: helperTextColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusNode: focusNode,
          validator: validator,
          readOnly: true,
          onTap: () {
            picker.DatePicker.showPicker(
              context,
              pickerModel: pickerModel,
              theme: picker.DatePickerTheme(
                itemStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Poppins'),
                cancelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                doneStyle: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Poppins',
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              locale: picker.LocaleType.id,
              onConfirm: onConfirmDate,
            );
          },
        ),
      ],
    );
  }
}
