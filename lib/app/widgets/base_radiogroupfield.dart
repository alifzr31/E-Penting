import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class BaseRadioGroupField<T> extends FormField<T> {
  new({
    super.key,
    String? label,
    bool mandatory = false,
    bool readOnly = false,
    required List<T> items,
    required String Function(T) itemLabelBuilder,
    super.onSaved,
    super.validator,
    super.initialValue,
    ValueChanged<T>? onChanged,
    double spacing = 10.0,
    double runSpacing = 8.0,
  }) : super(
         builder: (FormFieldState<T> state) {
           final hasError = state.hasError;

           return Align(
             alignment: .centerLeft,
             child: Column(
               crossAxisAlignment: .start,
               children: [
                 if (label != null) ...[
                   RichText(
                     text: TextSpan(
                       style: DefaultTextStyle.of(state.context).style,
                       children: [
                         TextSpan(
                           text: label,
                           style: const TextStyle(
                             fontSize: 12,
                             fontWeight: .w500,
                           ),
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
                   const SizedBox(height: 4),
                 ],
                 Wrap(
                   spacing: spacing,
                   runSpacing: runSpacing,
                   children: items.map((item) {
                     final isSelected = state.value == item;

                     return CupertinoButton(
                       alignment: .center,
                       minimumSize: .zero,
                       padding: .zero,
                       onPressed: readOnly || onChanged == null
                           ? null
                           : () {
                               state.didChange(item);
                               onChanged(item);
                             },
                       child: Row(
                         mainAxisSize: .min,
                         children: [
                           Icon(
                             isSelected
                                 ? RemixIcon.checkboxCircleFill
                                 : RemixIcon.checkboxBlankCircleLine,
                             size: 20,
                             color: AppColors.blueColor,
                           ),
                           const SizedBox(width: 4),
                           Text(
                             itemLabelBuilder(item),
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: isSelected ? .w500 : .w400,
                               color: Colors.black,
                               fontFamily: 'Poppins',
                             ),
                           ),
                         ],
                       ),
                     );
                   }).toList(),
                 ),
                 if (hasError) ...[
                   const SizedBox(height: 4),
                   Text(
                     state.errorText!,
                     style: TextStyle(fontSize: 12, color: Colors.red.shade600),
                   ),
                 ],
               ],
             ),
           );
         },
       );

  @override
  FormFieldState<T> createState() => _BaseRadioGroupFieldState<T>();
}

class _BaseRadioGroupFieldState<T> extends FormFieldState<T> {
  @override
  void didUpdateWidget(covariant BaseRadioGroupField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
