import 'dart:async';

import 'package:e_penting/app/widgets/base_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';

class BaseTypeaHeadField<T> extends StatelessWidget {
  const new({
    required this.itemBuilder,
    required this.onSelected,
    required this.suggestionsCallback,
    this.hint,
    this.controller,
    this.validator,
    this.debounceDuration,
    this.emptyLabel,
    this.readOnly = false,
    this.textInputAction,
    super.key,
  });

  final Widget Function(BuildContext context, T value) itemBuilder;
  final void Function(T value)? onSelected;
  final FutureOr<List<T>?> Function(String keyword) suggestionsCallback;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Duration? debounceDuration;
  final String? emptyLabel;
  final bool readOnly;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      controller: controller,
      debounceDuration: debounceDuration,
      builder: (context, controller, focusNode) {
        return BaseFormField(
          hint: hint,
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          readOnly: readOnly,
          textInputAction: textInputAction,
        );
      },
      decorationBuilder: (context, child) {
        return Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: .circular(6),
          clipBehavior: .antiAlias,
          child: child,
        );
      },
      hideKeyboardOnDrag: false,
      constraints: const BoxConstraints(maxHeight: 200),
      loadingBuilder: (context) {
        return const CircularProgressIndicator();
      },
      emptyBuilder: (context) {
        return Padding(
          padding: const .symmetric(vertical: 10, horizontal: 16),
          child: Text(
            emptyLabel ?? '',
            style: const TextStyle(fontSize: 14, fontWeight: .w500),
          ),
        );
      },
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      suggestionsCallback: suggestionsCallback,
    );
  }
}

class BaseTypeaHeadGroupField<T> extends StatelessWidget {
  const BaseTypeaHeadGroupField({
    required this.label,
    required this.itemBuilder,
    required this.onSelected,
    required this.suggestionsCallback,
    this.hint,
    this.mandatory = false,
    this.controller,
    this.validator,
    this.debounceDuration,
    this.emptyLabel,
    this.readOnly = false,
    this.textInputAction,
    super.key,
  });

  final String label;
  final Widget Function(BuildContext context, T value) itemBuilder;
  final void Function(T value)? onSelected;
  final FutureOr<List<T>?> Function(String keyword) suggestionsCallback;
  final String? hint;
  final bool mandatory;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final Duration? debounceDuration;
  final String? emptyLabel;
  final bool readOnly;
  final TextInputAction? textInputAction;

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
        TypeAheadField<T>(
          controller: controller,
          debounceDuration: debounceDuration,
          builder: (context, controller, focusNode) {
            return BaseFormField(
              hint: hint,
              controller: controller,
              focusNode: focusNode,
              validator: validator,
              readOnly: readOnly,
              textInputAction: textInputAction,
            );
          },
          decorationBuilder: (context, child) {
            return Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: .circular(6),
              clipBehavior: .antiAlias,
              child: child,
            );
          },
          hideKeyboardOnDrag: false,
          constraints: const BoxConstraints(maxHeight: 200),
          loadingBuilder: (context) {
            return BaseSkeletonizer(
              child: SingleChildScrollView(
                padding: const .all(10),
                child: Column(
                  mainAxisSize: .min,
                  children: List.generate(3, (index) {
                    return const Text(
                      'XXXXXXXXXXXXXXXXXXXXXXXX',
                      style: TextStyle(fontSize: 14),
                    );
                  }),
                ),
              ),
            );
          },
          emptyBuilder: (context) {
            return Padding(
              padding: const .symmetric(vertical: 10, horizontal: 16),
              child: Text(
                emptyLabel ?? '',
                style: const TextStyle(fontSize: 14, fontWeight: .w500),
              ),
            );
          },
          itemBuilder: itemBuilder,
          onSelected: onSelected,
          suggestionsCallback: suggestionsCallback,
        ),
      ],
    );
  }
}
