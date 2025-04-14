import 'package:epenting/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseFormField extends StatelessWidget {
  const BaseFormField({
    super.key,
    this.hint,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.helperText,
    this.helperTextColor,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.hintColor,
    this.borderColor,
    this.initialValue,
  });

  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? helperText;
  final Color? helperTextColor;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool readOnly;
  final Color? hintColor;
  final Color? borderColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      maxLength: maxLength,
      cursorColor: AppColors.orangeColor,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: hintColor ?? Colors.grey.shade400,
          fontWeight: FontWeight.w500,
        ),
        helperText: helperText,
        helperMaxLines: 2,
        errorMaxLines: 2,
        helperStyle: TextStyle(fontSize: 10.sp, color: helperTextColor),
        errorStyle: TextStyle(fontSize: 10.sp),
        counterText: '',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10),
        prefixIcon:
            prefixIcon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.only(left: 10, right: 2),
                  child: prefixIcon,
                ),
        prefixIconConstraints: BoxConstraints(minHeight: 26.r, minWidth: 26.r),
        suffixIcon:
            suffixIcon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.only(left: 2, right: 10),
                  child: suffixIcon,
                ),
        suffixIconConstraints: BoxConstraints(minHeight: 26.r, minWidth: 26.r),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColors.greyFormField),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColors.greyFormField),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColors.greyFormField),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
    );
  }
}

class BaseFormGroupField extends StatelessWidget {
  const BaseFormGroupField({
    super.key,
    required this.label,
    this.mandatory = false,
    this.hint,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.helperText,
    this.helperTextColor,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
  });

  final String label;
  final bool mandatory;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? helperText;
  final Color? helperTextColor;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: RichText(
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
                if (mandatory)
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
          ),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLines,
          maxLength: maxLength,
          cursorColor: AppColors.orangeColor,
          style: TextStyle(
            fontSize: 14.sp,
            color: readOnly ? Colors.grey.shade600 : null,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
            helperText: helperText,
            helperMaxLines: 2,
            errorMaxLines: 2,
            counterText: '',
            helperStyle: TextStyle(fontSize: 10.sp, color: helperTextColor),
            errorStyle: TextStyle(fontSize: 10.sp),
            prefixIcon:
                prefixIcon == null
                    ? null
                    : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 2),
                      child: prefixIcon,
                    ),
            prefixIconConstraints: BoxConstraints(
              minHeight: 26.r,
              minWidth: 26.r,
            ),
            suffixIcon:
                suffixIcon == null
                    ? null
                    : Padding(
                      padding: const EdgeInsets.only(left: 2, right: 10),
                      child: suffixIcon,
                    ),
            suffixIconConstraints: BoxConstraints(
              minHeight: 26.r,
              minWidth: 26.r,
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyFormField),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyFormField),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greyFormField),
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          initialValue: initialValue,
        ),
      ],
    );
  }
}
