import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:e_penting/app/utils/text_input_formatters/decimal_input_formatter.dart';
import 'package:e_penting/app/widgets/base_datepickerfield.dart';
import 'package:e_penting/app/widgets/base_dropdownfield.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/base_radiogroupfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class EditToddlerForm extends StatelessWidget {
  const new({
    required this.formKey,
    required this.toddlerNikController,
    required this.toddlerNoKkController,
    required this.toddlerFullNameController,
    required this.selectedBornDate,
    required this.bornDateController,
    required this.onSelectedBornDate,
    required this.selectedGender,
    required this.onSelectedGender,
    required this.toddlerNumberController,
    required this.toddlerWeightController,
    required this.toddlerHeightController,
    required this.toddlerHeadCircumferenceController,
    required this.gestationalAgeController,
    required this.selectedKiaBayiKecil,
    required this.onSelectedKiaBayiKecil,
    required this.selectedHasKiaBook,
    required this.onSelectedHasKiaBook,
    required this.selectedImd,
    required this.onSelectedImd,
    required this.parentNikController,
    required this.parentNameController,
    required this.parentPhoneNumberController,
    required this.addressController,
    required this.rts,
    required this.selectedRt,
    required this.onSelectedRt,
    required this.rws,
    required this.selectedRw,
    required this.onSelectedRw,
    required this.selectedBandungResident,
    required this.onSelectedBandungResident,
    required this.districtNameController,
    required this.subDistrictNameController,
    required this.healthFacilityNameController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController toddlerNikController;
  final TextEditingController toddlerNoKkController;
  final TextEditingController toddlerFullNameController;
  final DateTime? selectedBornDate;
  final TextEditingController bornDateController;
  final dynamic Function(DateTime) onSelectedBornDate;
  final Gender? selectedGender;
  final void Function(Gender value) onSelectedGender;
  final TextEditingController toddlerNumberController;
  final TextEditingController toddlerWeightController;
  final TextEditingController toddlerHeightController;
  final TextEditingController toddlerHeadCircumferenceController;
  final TextEditingController gestationalAgeController;
  final Boolean? selectedKiaBayiKecil;
  final void Function(Boolean value) onSelectedKiaBayiKecil;
  final Boolean? selectedHasKiaBook;
  final void Function(Boolean value) onSelectedHasKiaBook;
  final Boolean? selectedImd;
  final void Function(Boolean value) onSelectedImd;
  final TextEditingController parentNikController;
  final TextEditingController parentNameController;
  final TextEditingController parentPhoneNumberController;
  final TextEditingController addressController;
  final List<String> rts;
  final ValueNotifier<String?> selectedRt;
  final void Function(String? value) onSelectedRt;
  final List<String> rws;
  final ValueNotifier<String?> selectedRw;
  final void Function(String? value) onSelectedRw;
  final Boolean? selectedBandungResident;
  final void Function(Boolean value) onSelectedBandungResident;
  final TextEditingController districtNameController;
  final TextEditingController subDistrictNameController;
  final TextEditingController healthFacilityNameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseFormGroupField(
            label: 'NIK Balita',
            hint: 'Masukkan NIK balita',
            controller: toddlerNikController,
            mandatory: true,
            textInputAction: .next,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan NIK balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'No. Kartu Keluarga',
            hint: 'Masukkan No. Kartu Keluarga balita',
            controller: toddlerNoKkController,
            mandatory: true,
            textInputAction: .next,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan No. Kartu Keluarga balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Nama Lengkap Balita',
            hint: 'Masukkan nama lengkap balita',
            controller: toddlerFullNameController,
            mandatory: true,
            textInputAction: .next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan nama lengkap balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseDatePickerGroupField(
            label: 'Tanggal Lahir Balita',
            hint: 'Masukkan tanggal lahir balita',
            mandatory: true,
            controller: bornDateController,
            pickerModel: DatePickerModel(
              locale: .id,
              currentTime: selectedBornDate,
              maxTime: .now(),
            ),
            onConfirmDate: onSelectedBornDate,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan tanggal lahir balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField<Gender>(
            label: 'Jenis Kelamin Balita',
            mandatory: true,
            items: Gender.filteredValues,
            initialValue: selectedGender,
            itemLabelBuilder: (value) => value.label,
            onChanged: onSelectedGender,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih jenis kelamin balita';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Anak Ke',
            hint: 'Masukkan anak ke berapa',
            controller: toddlerNumberController,
            mandatory: true,
            textInputAction: .next,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan anak ke berapa';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BaseFormGroupField(
                  label: 'Berat Lahir',
                  hint: 'Masukkan berat lahir',
                  controller: toddlerWeightController,
                  mandatory: true,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('kg'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan berat lahir';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BaseFormGroupField(
                  label: 'Tinggi Lahir',
                  hint: 'Masukkan tinggi lahir',
                  controller: toddlerHeightController,
                  mandatory: true,
                  textInputAction: .next,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('cm'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan tinggi lahir';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Lingkar Kepala Lahir',
            hint: 'Masukkan lingkar kepala lahir',
            controller: toddlerHeadCircumferenceController,
            mandatory: true,
            textInputAction: .next,
            keyboardType: const .numberWithOptions(decimal: true),
            inputFormatters: [DecimalInputFormatter()],
            suffixIcon: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('cm'),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan lingkar kepala lahir';
              }

              return null;
            },
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
          BaseFormGroupField(
            label: 'Usia Kehamilan',
            hint: 'Masukkan usia kehamilan',
            controller: gestationalAgeController,
            mandatory: true,
            textInputAction: .next,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            suffixIcon: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('minggu'),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan usia kehamilan';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'KIA Bayi Kecil?',
            mandatory: true,
            items: Boolean.values,
            initialValue: selectedKiaBayiKecil,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedKiaBayiKecil,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih apakah KIA bayi kecil?';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Mempunyai Buku KIA?',
            mandatory: true,
            items: Boolean.values,
            initialValue: selectedHasKiaBook,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedHasKiaBook,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih apakah mempunyai buku KIA?';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'IMD',
            mandatory: true,
            items: Boolean.values,
            initialValue: selectedImd,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedImd,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih IMD';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'NIK Orang Tua atau NIK Panti',
            hint: 'Masukkan NIK orang tua atau NIK panti',
            controller: parentNikController,
            mandatory: true,
            textInputAction: .next,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan NIK orang tua atau NIK panti';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Nama Orang Tua atau Nama Panti',
            hint: 'Masukkan nama orang tua atau nama panti',
            controller: parentNameController,
            mandatory: true,
            textInputAction: .next,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan nama orang tua atau nama panti';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'No. HP Orang Tua atau No. HP Panti',
            hint: 'Masukkan no. hp orang tua atau no. hp panti',
            controller: parentPhoneNumberController,
            mandatory: true,
            textInputAction: .next,
            keyboardType: .phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan no. hp orang tua atau no. hp panti';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Alamat',
            hint: 'Masukkan alamat',
            controller: addressController,
            mandatory: true,
            textInputAction: .newline,
            maxLines: 4,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan alamat';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: BaseDropdownGroupField(
                  label: 'RT',
                  hint: 'Pilih RT',
                  mandatory: true,
                  value: selectedRt,
                  items: rts.map((e) {
                    return DropdownItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: onSelectedRt,
                  validator: (value) {
                    if (value == null) {
                      return 'Silahkan pilih RT';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BaseDropdownGroupField(
                  label: 'RW',
                  hint: 'Pilih RW',
                  mandatory: true,
                  value: selectedRw,
                  items: rws.map((e) {
                    return DropdownItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: onSelectedRw,
                  validator: (value) {
                    if (value == null) {
                      return 'Silahkan pilih RW';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Penduduk Kota Bandung?',
            items: Boolean.values,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            initialValue: selectedBandungResident,
            mandatory: true,
            onChanged: onSelectedBandungResident,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih apakah penduduk kota bandung?';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Kecamatan',
            hint: 'Masukkan kecamatan',
            mandatory: true,
            controller: districtNameController,
            readOnly: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan kecamatan';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Kelurahan',
            hint: 'Masukkan kelurahan',
            mandatory: true,
            controller: subDistrictNameController,
            readOnly: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan kelurahan';
              }

              return null;
            },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Puskesmas',
            hint: 'Masukkan puskesmas',
            mandatory: true,
            controller: healthFacilityNameController,
            readOnly: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Silahkan masukkan puskesmas';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
