import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:flutter/material.dart';

class BaseDatePickerField extends StatelessWidget {
  const BaseDatePickerField({
    required this.pickerModel,
    this.hint,
    this.controller,
    this.focusNode,
    this.readOnly = false,
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
  final bool readOnly;
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
      isDate: true,
      readOnly: readOnly,
      onTap: readOnly
          ? null
          : () {
              picker.DatePicker.showPicker(
                context,
                pickerModel: pickerModel,
                theme: picker.DatePickerTheme(
                  itemStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  cancelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.grey.shade600,
                    fontWeight: .w500,
                  ),
                  doneStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: AppColors.blueColor,
                    fontWeight: .w500,
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
    this.readOnly = false,
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
  final bool readOnly;
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
          alignment: .centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(fontSize: 12, fontWeight: .w500),
                ),
                if (mandatory)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.red.shade700,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        BaseFormField(
          controller: controller,
          hint: hint,
          helperText: helperText,
          helperTextColor: helperTextColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusNode: focusNode,
          validator: validator,
          isDate: true,
          readOnly: readOnly,
          onTap: readOnly
              ? null
              : () {
                  picker.DatePicker.showPicker(
                    context,
                    pickerModel: pickerModel,
                    theme: picker.DatePickerTheme(
                      itemStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                      cancelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.grey.shade600,
                        fontWeight: .w500,
                      ),
                      doneStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: AppColors.blueColor,
                        fontWeight: .w500,
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

class BaseDateTimePickerField extends StatelessWidget {
  const BaseDateTimePickerField({
    this.currentDateTime,
    this.minDateTime,
    this.maxDateTime,
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

  final DateTime? currentDateTime;
  final DateTime? minDateTime;
  final DateTime? maxDateTime;
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
      isDate: true,
      onTap: () {
        picker.DatePicker.showDateTimePicker(
          context,
          currentTime: currentDateTime,
          minTime: minDateTime,
          maxTime: maxDateTime,
          theme: picker.DatePickerTheme(
            itemStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            cancelStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Colors.grey.shade600,
              fontWeight: .w500,
            ),
            doneStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: AppColors.blueColor,
              fontWeight: .w500,
            ),
          ),
          locale: picker.LocaleType.id,
          onConfirm: onConfirmDate,
        );
      },
    );
  }
}

class BaseDateTimePickerGroupField extends StatelessWidget {
  const BaseDateTimePickerGroupField({
    required this.label,
    this.currentDateTime,
    this.minDateTime,
    this.maxDateTime,
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
  final DateTime? currentDateTime;
  final DateTime? minDateTime;
  final DateTime? maxDateTime;
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
          alignment: .centerLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(fontSize: 12, fontWeight: .w500),
                ),
                if (mandatory)
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.red.shade700,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        BaseFormField(
          controller: controller,
          hint: hint,
          helperText: helperText,
          helperTextColor: helperTextColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusNode: focusNode,
          validator: validator,
          isDate: true,
          onTap: () {
            picker.DatePicker.showDateTimePicker(
              context,
              currentTime: currentDateTime,
              minTime: minDateTime,
              maxTime: maxDateTime,
              theme: picker.DatePickerTheme(
                itemStyle: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
                cancelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.grey.shade600,
                  fontWeight: .w500,
                ),
                doneStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: AppColors.blueColor,
                  fontWeight: .w500,
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
