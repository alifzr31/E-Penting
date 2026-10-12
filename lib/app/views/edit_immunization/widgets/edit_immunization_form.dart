import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/utils/enums/immunization_type.dart';
import 'package:e_penting/app/widgets/base_checkboxgroupfield.dart';
import 'package:e_penting/app/widgets/base_datepickerfield.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class EditImmunizationForm extends StatelessWidget {
  const new({
    required this.formKey,
    required this.immunizationDateController,
    required this.selectedImmunizationDate,
    required this.onSelectedImmunizationDate,
    required this.selectedToddlerId,
    required this.toddlerNameController,
    required this.onSelectedToddlerName,
    required this.toddlerNikController,
    required this.toddlerBornDateController,
    required this.selectedImmunizationType,
    required this.onSelectedImmunizationType,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController immunizationDateController;
  final DateTime? selectedImmunizationDate;
  final dynamic Function(DateTime date) onSelectedImmunizationDate;
  final int? selectedToddlerId;
  final TextEditingController toddlerNameController;
  final void Function(Toddler toddler) onSelectedToddlerName;
  final TextEditingController toddlerNikController;
  final TextEditingController toddlerBornDateController;
  final List<ImmunizationType> selectedImmunizationType;
  final void Function(List<ImmunizationType> values) onSelectedImmunizationType;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseDatePickerGroupField(
            label: 'Tanggal Imunisasi',
            hint: 'Pilih tanggal imunisasi',
            controller: immunizationDateController,
            mandatory: true,
            pickerModel: DatePickerModel(
              locale: .id,
              currentTime: selectedImmunizationDate,
              maxTime: DateTime.now(),
            ),
            onConfirmDate: onSelectedImmunizationDate,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan pilih tanggal imunisasi';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Nama Balita',
            hint: 'Masukkan nama balita',
            mandatory: true,
            readOnly: true,
            controller: toddlerNameController,
            textInputAction: .next,
            validator: (value) {
              if (value!.isEmpty || selectedToddlerId == null) {
                return 'Silahkan masukkan nama balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'NIK Balita',
            hint: 'Otomatis terisi dari nama yang dipilih',
            mandatory: true,
            controller: toddlerNikController,
            readOnly: true,
            textInputAction: .next,
            maxLength: 16,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan pilih nama balita untuk mengisi NIK balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Tanggal Lahir Balita',
            hint: 'Otomatis terisi dari nama yang dipilih',
            mandatory: true,
            controller: toddlerBornDateController,
            readOnly: true,
            textInputAction: .next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan pilih nama balita untuk mengisi tanggal lahir balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseCheckboxGroupField(
            label: 'Jenis Imunisasi',
            initialValue: selectedImmunizationType,
            mandatory: true,
            crossAxisCount: 2,
            items: ImmunizationType.filteredValues,
            itemLabelBuilder: (value) {
              return value.label;
            },
            onChanged: onSelectedImmunizationType,
            validator: (value) {
              if (selectedImmunizationType.isEmpty) {
                return 'Silahkan pilih jenis imunisasi';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
