import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/utils/enums/boolean.dart';
import 'package:e_penting/app/utils/enums/gender.dart';
import 'package:e_penting/app/utils/text_input_formatters/decimal_input_formatter.dart';
import 'package:e_penting/app/widgets/base_datepickerfield.dart';
import 'package:e_penting/app/widgets/base_dropdownfield.dart';
import 'package:e_penting/app/widgets/base_formfield.dart';
import 'package:e_penting/app/widgets/base_iconbutton.dart';
import 'package:e_penting/app/widgets/base_radiogroupfield.dart';
import 'package:e_penting/app/widgets/base_typeaheadfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:string_validator/string_validator.dart';

class CreateToddlerForm extends StatelessWidget {
  const new({
    required this.formKey,
    required this.selectedNewToddler,
    required this.onSelectedNewToddler,
    required this.onGenerateDummyNik,
    required this.toddlerNikController,
    required this.toddlerNoKkController,
    required this.toddlerFullNameController,
    required this.onSelectedToddlerFullName,
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
    required this.beforeDistrictNameController,
    required this.beforeSubDistrictNameController,
    required this.beforeHealthFacilityNameController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final Boolean selectedNewToddler;
  final void Function(Boolean value) onSelectedNewToddler;
  final VoidCallback onGenerateDummyNik;
  final TextEditingController toddlerNikController;
  final TextEditingController toddlerNoKkController;
  final TextEditingController toddlerFullNameController;
  final void Function(Toddler toddler) onSelectedToddlerFullName;
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
  final TextEditingController beforeDistrictNameController;
  final TextEditingController beforeSubDistrictNameController;
  final TextEditingController beforeHealthFacilityNameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          BaseRadioGroupField(
            label: 'Balita Baru',
            mandatory: true,
            items: Boolean.values,
            initialValue: selectedNewToddler,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Pindah',
            onChanged: onSelectedNewToddler,
            validator: (value) {
              if (value == null) {
                return 'Silahkan pilih status balita baru';
              }

              return null;
            },
          ),
          if (!selectedNewToddler.valueBool) ...[
            const SizedBox(height: 6),
            Container(
              width: .infinity,
              padding: const .symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: .circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    RemixIcon.information2Line,
                    size: 18,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Silahkan ketik dan pilih nama balita, seluruh kolom dibawah ini akan otomatis terisi berdasarkan balita yang dipilih.',
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
          ],
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'NIK Balita',
            hint: 'Masukkan NIK balita',
            controller: toddlerNikController,
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            readOnly: !selectedNewToddler.valueBool,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            suffixIcon: selectedNewToddler.valueBool
                ? BaseIconButton(
                    icon: RemixIcon.dice5Line,
                    size: 18,
                    onPressed: onGenerateDummyNik,
                  )
                : null,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan NIK balita';
                    } else {
                      if (!value.isInt) {
                        return 'NIK balita yang dimasukkan tidak valid';
                      } else {
                        if (value.length != 16) {
                          return 'NIK balita harus berjumlah 16 digit';
                        }
                      }
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'No. Kartu Keluarga',
            hint: 'Masukkan No. Kartu Keluarga balita',
            controller: toddlerNoKkController,
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            readOnly: !selectedNewToddler.valueBool,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan No. Kartu Keluarga balita';
                    } else {
                      if (!value.isInt) {
                        return 'No. kartu keluarga yang dimasukkan tidak valid';
                      } else {
                        if (value.length != 16) {
                          return 'No. kartu keluarga harus berjumlah 16 digit';
                        }
                      }
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          if (selectedNewToddler.valueBool) ...[
            BaseFormGroupField(
              label: 'Nama Lengkap Balita',
              hint: 'Masukkan nama lengkap balita',
              controller: toddlerFullNameController,
              mandatory: selectedNewToddler.valueBool,
              textInputAction: .next,
              validator: !selectedNewToddler.valueBool
                  ? null
                  : (value) {
                      if (value!.isEmpty) {
                        return 'Silahkan masukkan nama lengkap balita';
                      }

                      return null;
                    },
            ),
          ] else ...[
            BaseTypeaHeadGroupField<Toddler>(
              label: 'Nama Lengkap Balita',
              hint: 'Masukkan nama lengkap balita',
              controller: toddlerFullNameController,
              debounceDuration: const Duration(milliseconds: 500),
              mandatory: true,
              textInputAction: .next,
              emptyLabel: 'Balita dengan nama tersebut tidak ditemukan',
              itemBuilder: (context, value) {
                return Padding(
                  padding: const .all(10),
                  child: Text(value.namaAnak ?? ''),
                );
              },
              onSelected: onSelectedToddlerFullName,
              suggestionsCallback: (keyword) async {
                if (keyword.isEmpty || keyword.length < 3) {
                  return const [];
                }

                final toddlerCubit = context.read<ToddlerCubit>();

                await toddlerCubit.fetchSearchMoveToddler(keyword: keyword);

                if (!context.mounted) return const [];

                return toddlerCubit.state.toddlers;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Silahkan masukkan nama lengkap balita';
                }

                return null;
              },
            ),
          ],
          const SizedBox(height: 10),
          BaseDatePickerGroupField(
            label: 'Tanggal Lahir Balita',
            hint: 'Masukkan tanggal lahir balita',
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            controller: bornDateController,
            pickerModel: DatePickerModel(
              locale: .id,
              currentTime: selectedBornDate,
              maxTime: .now(),
            ),
            onConfirmDate: onSelectedBornDate,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan tanggal lahir balita';
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField<Gender>(
            label: 'Jenis Kelamin Balita',
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            items: Gender.filteredValues,
            initialValue: selectedGender,
            itemLabelBuilder: (value) => value.label,
            onChanged: onSelectedGender,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            keyboardType: .number,
            readOnly: !selectedNewToddler.valueBool,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
                  mandatory: selectedNewToddler.valueBool,
                  textInputAction: .next,
                  readOnly: !selectedNewToddler.valueBool,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('kg'),
                  ),
                  validator: !selectedNewToddler.valueBool
                      ? null
                      : (value) {
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
                  mandatory: selectedNewToddler.valueBool,
                  textInputAction: .next,
                  readOnly: !selectedNewToddler.valueBool,
                  keyboardType: const .numberWithOptions(decimal: true),
                  inputFormatters: [DecimalInputFormatter()],
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('cm'),
                  ),
                  validator: !selectedNewToddler.valueBool
                      ? null
                      : (value) {
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
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            readOnly: !selectedNewToddler.valueBool,
            keyboardType: const .numberWithOptions(decimal: true),
            inputFormatters: [DecimalInputFormatter()],
            suffixIcon: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('cm'),
            ),
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            keyboardType: .number,
            readOnly: !selectedNewToddler.valueBool,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            suffixIcon: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('minggu'),
            ),
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan usia kehamilan';
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'KIA Bayi Kecil?',
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            items: Boolean.values,
            initialValue: selectedKiaBayiKecil,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedKiaBayiKecil,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value == null) {
                      return 'Silahkan pilih apakah KIA bayi kecil?';
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'Mempunyai Buku KIA?',
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            items: Boolean.values,
            initialValue: selectedHasKiaBook,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedHasKiaBook,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value == null) {
                      return 'Silahkan pilih apakah mempunyai buku KIA?';
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseRadioGroupField(
            label: 'IMD',
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            items: Boolean.values,
            initialValue: selectedImd,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            onChanged: onSelectedImd,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
            mandatory: selectedNewToddler.valueBool,
            readOnly: !selectedNewToddler.valueBool,
            textInputAction: .next,
            maxLength: 16,
            keyboardType: .number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan NIK orang tua atau NIK panti';
                    } else {
                      if (!value.isInt) {
                        return 'NIK orang tua atau NIK panti yang dimasukkan tidak valid';
                      } else {
                        if (value.length != 16) {
                          return 'NIK orang tua atau NIK panti harus berjumlah 16 digit';
                        }
                      }
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Nama Orang Tua atau Nama Panti',
            hint: 'Masukkan nama orang tua atau nama panti',
            controller: parentNameController,
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            readOnly: !selectedNewToddler.valueBool,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .next,
            readOnly: !selectedNewToddler.valueBool,
            keyboardType: .phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'Silahkan masukkan no. hp orang tua atau no. hp panti';
                    } else {
                      if (!value.isNumeric) {
                        return 'No. hp orang tua atau no. hp panti yang dimasukkan tidak valid';
                      } else {
                        if (value.length < 10 || value.length > 14) {
                          return 'No. hp orang tua atau no. hp panti harus terdiri dari 10 sampai 14 digit';
                        }
                      }
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          BaseFormGroupField(
            label: 'Alamat',
            hint: 'Masukkan alamat',
            controller: addressController,
            mandatory: selectedNewToddler.valueBool,
            textInputAction: .newline,
            readOnly: !selectedNewToddler.valueBool,
            maxLines: 4,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
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
                  mandatory: selectedNewToddler.valueBool,
                  value: selectedRt,
                  items: rts.map((e) {
                    return DropdownItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: !selectedNewToddler.valueBool
                      ? null
                      : onSelectedRt,
                  validator: !selectedNewToddler.valueBool
                      ? null
                      : (value) {
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
                  mandatory: selectedNewToddler.valueBool,
                  value: selectedRw,
                  items: rws.map((e) {
                    return DropdownItem(value: e, child: Text(e));
                  }).toList(),
                  onChanged: !selectedNewToddler.valueBool
                      ? null
                      : onSelectedRw,
                  validator: !selectedNewToddler.valueBool
                      ? null
                      : (value) {
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
            readOnly: !selectedNewToddler.valueBool,
            itemLabelBuilder: (value) => value.valueBool ? 'Ya' : 'Tidak',
            initialValue: selectedBandungResident,
            mandatory: selectedNewToddler.valueBool,
            onChanged: onSelectedBandungResident,
            validator: !selectedNewToddler.valueBool
                ? null
                : (value) {
                    if (value == null) {
                      return 'Silahkan pilih apakah penduduk kota bandung?';
                    }

                    return null;
                  },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (!selectedNewToddler.valueBool) ...[
                Expanded(
                  key: const ValueKey('before_region_section_key'),
                  child: Column(
                    children: [
                      BaseFormGroupField(
                        label: 'Kecamatan Asal',
                        hint: 'Masukkan kecamatan asal',
                        mandatory: selectedNewToddler.valueBool,
                        controller: beforeDistrictNameController,
                        readOnly: true,
                        validator: !selectedNewToddler.valueBool
                            ? null
                            : (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukkan kecamatan asal';
                                }

                                return null;
                              },
                      ),
                      const SizedBox(height: 10),
                      BaseFormGroupField(
                        label: 'Kelurahan Asal',
                        hint: 'Masukkan kelurahan asal',
                        mandatory: selectedNewToddler.valueBool,
                        controller: beforeSubDistrictNameController,
                        readOnly: true,
                        validator: !selectedNewToddler.valueBool
                            ? null
                            : (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukkan kelurahan asal';
                                }

                                return null;
                              },
                      ),
                      const SizedBox(height: 10),
                      BaseFormGroupField(
                        label: 'Puskesmas Asal',
                        hint: 'Masukkan puskesmas asal',
                        mandatory: selectedNewToddler.valueBool,
                        controller: beforeHealthFacilityNameController,
                        readOnly: true,
                        validator: !selectedNewToddler.valueBool
                            ? null
                            : (value) {
                                if (value!.isEmpty) {
                                  return 'Silahkan masukkan puskesmas asal';
                                }

                                return null;
                              },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Column(
                  children: [
                    BaseFormGroupField(
                      label: 'Kecamatan',
                      hint: 'Masukkan kecamatan',
                      mandatory: selectedNewToddler.valueBool,
                      controller: districtNameController,
                      readOnly: true,
                      validator: !selectedNewToddler.valueBool
                          ? null
                          : (value) {
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
                      mandatory: selectedNewToddler.valueBool,
                      controller: subDistrictNameController,
                      readOnly: true,
                      validator: !selectedNewToddler.valueBool
                          ? null
                          : (value) {
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
                      mandatory: selectedNewToddler.valueBool,
                      controller: healthFacilityNameController,
                      readOnly: true,
                      validator: !selectedNewToddler.valueBool
                          ? null
                          : (value) {
                              if (value!.isEmpty) {
                                return 'Silahkan masukkan puskesmas';
                              }

                              return null;
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
