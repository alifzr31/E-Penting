import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class BaseCheckboxGroupField<T> extends FormField<List<T>> {
  BaseCheckboxGroupField({
    super.key,
    String? label,
    bool mandatory = false,
    bool readOnly = false,
    required List<T> items,
    required String Function(T) itemLabelBuilder,
    super.onSaved,
    super.validator,
    List<T>? initialValue,
    ValueChanged<List<T>>? onChanged,
    double spacing = 10.0,
    double runSpacing = 8.0,
    int? crossAxisCount,
  }) : super(
         initialValue: initialValue ?? [],
         builder: (FormFieldState<List<T>> state) {
           final hasError = state.hasError;
           final selectedItems = state.value ?? [];

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
                 LayoutBuilder(
                   builder: (context, constraints) {
                     final double? itemWidth = crossAxisCount != null
                         ? (constraints.maxWidth -
                                   (spacing * (crossAxisCount - 1))) /
                               crossAxisCount
                         : null;

                     return Wrap(
                       spacing: spacing,
                       runSpacing: runSpacing,
                       children: items.map((item) {
                         final isSelected = selectedItems.contains(item);

                         Widget buttonChild = Row(
                           mainAxisSize: .min,
                           children: [
                             Icon(
                               isSelected
                                   ? RemixIcon.checkboxFill
                                   : RemixIcon.checkboxBlankLine,
                               size: 20,
                               color: AppColors.blueColor,
                             ),
                             const SizedBox(width: 4),
                             Flexible(
                               child: Text(
                                 itemLabelBuilder(item),
                                 style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: isSelected ? .w500 : .w400,
                                   color: Colors.black,
                                   fontFamily: 'Poppins',
                                 ),
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                               ),
                             ),
                           ],
                         );

                         Widget button = CupertinoButton(
                           alignment: .centerLeft,
                           minimumSize: .zero,
                           padding: .zero,
                           onPressed: readOnly || onChanged == null
                               ? null
                               : () {
                                   final newItems = List<T>.from(selectedItems);
                                   if (isSelected) {
                                     newItems.remove(item);
                                   } else {
                                     newItems.add(item);
                                   }

                                   state.didChange(newItems);
                                   onChanged(newItems);
                                 },
                           child: buttonChild,
                         );

                         if (itemWidth != null) {
                           return SizedBox(width: itemWidth, child: button);
                         }
                         return button;
                       }).toList(),
                     );
                   },
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
  FormFieldState<List<T>> createState() => _BaseCheckboxGroupFieldState<T>();
}

class _BaseCheckboxGroupFieldState<T> extends FormFieldState<List<T>> {
  @override
  void didUpdateWidget(covariant BaseCheckboxGroupField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.initialValue, oldWidget.initialValue)) {
      setValue(widget.initialValue);
    }
  }
}
