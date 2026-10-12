import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/measurement_type.dart';
import 'package:e_penting/app/utils/extensions/string_extension.dart';
import 'package:e_penting/app/utils/text_input_formatters/decimal_input_formatter.dart';
import 'package:e_penting/app/widgets/base_checkboxgroupfield.dart';
import 'package:e_penting/app/widgets/base_datepickerfield.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/base_radiogroupfield.dart';
import 'package:e_penting/app/widgets/base_typeaheadfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CreateMeasurementForm extends StatelessWidget {
  const new({
    required this.formKey,
    required this.measurementDateController,
    required this.selectedMeasurementDate,
    required this.onSelectedMeasurementDate,
    required this.selectedToddlerId,
    required this.toddlerNameController,
    required this.onSelectedToddlerName,
    required this.toddlerNikController,
    required this.toddlerBornDateController,
    required this.selectedMeasurementType,
    required this.onSelectedMeasurementType,
    required this.weightController,
    required this.heightController,
    required this.lilaController,
    required this.headCircumferenceController,
    required this.selectedAsiMonths,
    required this.onSelectedAsiMonths,
    required this.selectedGivenVitA,
    required this.onSelectedGivenVitA,
    required this.givenVitANumberController,
    required this.selectedPittingEdema,
    required this.onSelectedPittingEdema,
    required this.selectedDegrees,
    required this.onSelectedDegrees,
    required this.selectedMotherToddlerClass,
    required this.onSelectedMotherToddlerClass,
    required this.selectedMbg,
    required this.onSelectedMbg,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController measurementDateController;
  final DateTime? selectedMeasurementDate;
  final dynamic Function(DateTime date) onSelectedMeasurementDate;
  final int? selectedToddlerId;
  final TextEditingController toddlerNameController;
  final void Function(Toddler toddler) onSelectedToddlerName;
  final TextEditingController toddlerNikController;
  final TextEditingController toddlerBornDateController;
  final MeasurementType selectedMeasurementType;
  final void Function(MeasurementType value) onSelectedMeasurementType;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController lilaController;
  final TextEditingController headCircumferenceController;
  final List<int> selectedAsiMonths;
  final void Function(List<int> value) onSelectedAsiMonths;
  final Boolean? selectedGivenVitA;
  final void Function(Boolean value) onSelectedGivenVitA;
  final TextEditingController givenVitANumberController;
  final Boolean? selectedPittingEdema;
  final void Function(Boolean value) onSelectedPittingEdema;
  final int? selectedDegrees;
  final void Function(int value) onSelectedDegrees;
  final Boolean? selectedMotherToddlerClass;
  final void Function(Boolean value) onSelectedMotherToddlerClass;
  final Boolean? selectedMbg;
  final void Function(Boolean value) onSelectedMbg;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseDatePickerGroupField(
            label: 'Tanggal Pengukuran',
            hint: 'Pilih tanggal pengukuran',
            mandatory: true,
            controller: measurementDateController,
            pickerModel: DatePickerModel(
              currentTime: selectedMeasurementDate,
              locale: .id,
              maxTime: .now(),
            ),
            onConfirmDate: onSelectedMeasurementDate,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan pilih tanggal pengukuran';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseTypeaHeadGroupField<Toddler>(
            label: 'Nama Balita',
            hint: 'Masukkan nama balita',
            mandatory: true,
            controller: toddlerNameController,
            debounceDuration: const Duration(milliseconds: 500),
            emptyLabel: 'Balita dengan nama tersebut tidak ditemukan',
            textInputAction: .next,
            validator: (value) {
              if (value!.isEmpty || selectedToddlerId == null) {
                return 'Silahkan masukkan nama balita';
              }

              return null;
            },
            itemBuilder: (context, value) {
              return Padding(
                padding: const .all(10),
                child: Text(value.namaAnak ?? ''),
              );
            },
            onSelected: onSelectedToddlerName,
            suggestionsCallback: (keyword) async {
              if (keyword.isEmpty) {
                return const [];
              }

              final toddlerCubit = context.read<ToddlerCubit>();

              await toddlerCubit.fetchSearchToddlers(keyword: keyword);

              if (!context.mounted) return const [];

              return toddlerCubit.state.toddlers;
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
          BaseRadioGroupField(
            label: 'Cara Pengukuran',
            mandatory: true,
            initialValue: selectedMeasurementType,
            items: MeasurementType.filteredValues,
            itemLabelBuilder: (value) {
              return value.label;
            },
            onChanged: onSelectedMeasurementType,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih cara pengukuran';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BaseFormGroupField(
                  label: 'Berat Badan',
                  hint: 'Masukkan berat badan',
                  mandatory: true,
                  controller: weightController,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('kg'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan berat badan';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BaseFormGroupField(
                  label: selectedMeasurementType == .stand
                      ? 'Tinggi Badan'
                      : selectedMeasurementType == .supine
                      ? 'Panjang Badan'
                      : '',
                  hint: selectedMeasurementType == .stand
                      ? 'Masukkan tinggi badan'
                      : selectedMeasurementType == .supine
                      ? 'Masukkan panjang badan'
                      : '',
                  mandatory: true,
                  controller: heightController,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('cm'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      switch (selectedMeasurementType) {
                        case .stand:
                          return 'Silahkan masukkan tinggi badan';
                        case .supine:
                          return 'Silahkan masukkan panjang badan';
                        default:
                      }
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: .infinity,
            padding: const .symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: .circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  RemixIcon.information2Line,
                  size: 16,
                  color: Colors.orange.shade600,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Pastikan ${selectedMeasurementType == .stand ? 'tinggi' : 'panjang'} badan yang anda masukkan adalah angka hasil pengukuran yang belum di koreksi dengan 0.7 cm',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.orange.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: .end,
            children: [
              Expanded(
                child: BaseFormGroupField(
                  label: 'Lingkar Lengan Atas (LILA)',
                  hint: 'Masukkan lingkar lengan atas (LILA)',
                  mandatory: true,
                  controller: lilaController,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('cm'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan lingkar lengan atas (LILA)';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BaseFormGroupField(
                  label: 'Lingkar Kepala',
                  hint: 'Masukkan lingkar kepala',
                  mandatory: true,
                  controller: headCircumferenceController,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('cm'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan lingkar kepala';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: .infinity,
            padding: const .symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: .circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  RemixIcon.information2Line,
                  size: 16,
                  color: Colors.blue.shade600,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Gunakan titik (.) untuk koma',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          BaseCheckboxGroupField(
            label: 'Pemberian ASI',
            initialValue: selectedAsiMonths,
            crossAxisCount: 2,
            items: List.generate(7, (index) {
              return index;
            }),
            itemLabelBuilder: (value) {
              return 'Bulan ke-$value';
            },
            onChanged: onSelectedAsiMonths,
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Pemberian Vitamin A',
            mandatory: true,
            initialValue: selectedGivenVitA,
            items: Boolean.values,
            itemLabelBuilder: (value) {
              return value.valueString.capitalize();
            },
            onChanged: onSelectedGivenVitA,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih pemberian vitamin A';
              }

              return null;
            },
          ),
          if (selectedGivenVitA != null && selectedGivenVitA == .yes) ...[
            const SizedBox(height: 10),
            BaseFormGroupField(
              label: 'Jumlah Vitamin A yang Diberikan',
              hint: 'Masukkan jumlah vitamin A yang diberikan',
              mandatory: true,
              controller: givenVitANumberController,
              keyboardType: .number,
              textInputAction: .next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Silahkan masukkan jumlah vitamin A yang diberikan';
                }

                return null;
              },
            ),
          ],
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Pitting Edema',
            mandatory: true,
            initialValue: selectedPittingEdema,
            items: Boolean.values,
            itemLabelBuilder: (value) {
              return value.valueString.capitalize();
            },
            onChanged: onSelectedPittingEdema,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih pitting edema';
              }

              return null;
            },
          ),
          if (selectedPittingEdema != null && selectedPittingEdema == .yes) ...[
            const SizedBox(height: 10),
            BaseRadioGroupField(
              label: 'Suhu Derajat',
              mandatory: true,
              initialValue: selectedDegrees,
              items: List.generate(3, (index) {
                return index + 1;
              }),
              itemLabelBuilder: (value) {
                return 'Suhu +$value Derajat';
              },
              onChanged: onSelectedDegrees,
              validator: (value) {
                if (value == null) {
                  return 'Silahkan pilih suhu derajat';
                }

                return null;
              },
            ),
          ],
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Kelas Ibu Balita',
            mandatory: true,
            initialValue: selectedMotherToddlerClass,
            items: Boolean.values,
            itemLabelBuilder: (value) {
              return value.valueString.capitalize();
            },
            onChanged: onSelectedMotherToddlerClass,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih kelas ibu balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Dapat MBG?',
            mandatory: true,
            initialValue: selectedMbg,
            items: Boolean.values,
            itemLabelBuilder: (value) {
              return value.valueString.capitalize();
            },
            onChanged: onSelectedMbg,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih apakah dapat MBG?';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
