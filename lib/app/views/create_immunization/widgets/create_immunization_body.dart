import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/utils/enums/immunization_type.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/views/create_immunization/widgets/create_immunization_form.dart';
import 'package:e_penting/app/widgets/base_button.dart';
import 'package:e_penting/app/widgets/show_customtoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';

class CreateImmunizationBody extends StatefulWidget {
  const new({super.key});

  @override
  State<CreateImmunizationBody> createState() => _CreateImmunizationBodyState();
}

class _CreateImmunizationBodyState extends State<CreateImmunizationBody> {
  final _formKey = GlobalKey<FormState>();
  final _immunizationDateController = TextEditingController();
  DateTime? _selectedImmunizationDate;
  int? _selectedToddlerId;
  final _toddlerNameController = TextEditingController();
  final _toddlerNikController = TextEditingController();
  final _toddlerBornDateController = TextEditingController();
  final List<ImmunizationType> _selectedImmunizationType = [];

  @override
  void dispose() {
    _immunizationDateController.dispose();
    _toddlerNameController.dispose();
    _toddlerNikController.dispose();
    _toddlerBornDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImmunizationCubit, ImmunizationState>(
      listenWhen: (previous, current) {
        return previous.formStatus != current.formStatus;
      },
      listener: (context, state) {
        switch (state.formStatus) {
          case .loading:
            context.loaderOverlay.show();
          case .success:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .success,
              title: 'Tambah Imunisasi Berhasil',
              description: state.formResponseData?['message'],
            );
            Navigator.pop(context, true);
          case .error:
            context.loaderOverlay.hide();
            showCustomToast(
              context,
              type: .error,
              title: 'Tambah Imunisasi Gagal',
              description: state.formErrorMessage,
            );
          default:
            return;
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const .only(top: 16, left: 16, right: 16, bottom: 6),
              child: SizedBox(
                width: .infinity,
                child: Material(
                  elevation: 1,
                  color: Colors.white,
                  clipBehavior: .antiAlias,
                  borderRadius: .circular(10),
                  child: Padding(
                    padding: const .all(16),
                    child: CreateImmunizationForm(
                      formKey: _formKey,
                      immunizationDateController: _immunizationDateController,
                      selectedImmunizationDate: _selectedImmunizationDate,
                      onSelectedImmunizationDate: (date) {
                        _selectedImmunizationDate = date;
                        _immunizationDateController.text = date.dayMonthYear();

                        setState(() {});
                      },
                      selectedToddlerId: _selectedToddlerId,
                      toddlerNameController: _toddlerNameController,
                      onSelectedToddlerName: (value) {
                        _selectedToddlerId = value.id;
                        _toddlerNameController.text = value.namaAnak ?? '';
                        _toddlerNikController.text = value.nikAnak ?? '';
                        _toddlerBornDateController.text =
                            value.tanggalLahir?.dayMonthYear() ?? '';

                        setState(() {});
                      },
                      toddlerNikController: _toddlerNikController,
                      toddlerBornDateController: _toddlerBornDateController,
                      selectedImmunizationType: _selectedImmunizationType,
                      onSelectedImmunizationType: (value) {
                        _selectedImmunizationType.clear();
                        _selectedImmunizationType.addAll(value);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const .only(top: 10, left: 16, right: 16, bottom: 16),
              child: BaseButtonIcon(
                width: .infinity,
                icon: RemixIcon.save2Line,
                label: 'Simpan',
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<ImmunizationCubit>().createImmunization(
                      toddlerId: _selectedToddlerId,
                      immunizationDate: _selectedImmunizationDate,
                      hb: _selectedImmunizationType.contains(
                        ImmunizationType.hb,
                      ),
                      dptHb1: _selectedImmunizationType.contains(
                        ImmunizationType.dptHb1,
                      ),
                      dptHb2: _selectedImmunizationType.contains(
                        ImmunizationType.dptHb2,
                      ),
                      dptHb3: _selectedImmunizationType.contains(
                        ImmunizationType.dptHb3,
                      ),
                      dptHbl: _selectedImmunizationType.contains(
                        ImmunizationType.dptHbl,
                      ),
                      polio1: _selectedImmunizationType.contains(
                        ImmunizationType.polio1,
                      ),
                      polio2: _selectedImmunizationType.contains(
                        ImmunizationType.polio2,
                      ),
                      polio3: _selectedImmunizationType.contains(
                        ImmunizationType.polio3,
                      ),
                      polio4: _selectedImmunizationType.contains(
                        ImmunizationType.polio4,
                      ),
                      campak: _selectedImmunizationType.contains(
                        ImmunizationType.campak,
                      ),
                      campakL: _selectedImmunizationType.contains(
                        ImmunizationType.campakL,
                      ),
                      bcg: _selectedImmunizationType.contains(
                        ImmunizationType.bcg,
                      ),
                      ipv1: _selectedImmunizationType.contains(
                        ImmunizationType.ipv1,
                      ),
                      ipv2: _selectedImmunizationType.contains(
                        ImmunizationType.ipv2,
                      ),
                      rotav1: _selectedImmunizationType.contains(
                        ImmunizationType.rotav1,
                      ),
                      rotav2: _selectedImmunizationType.contains(
                        ImmunizationType.rotav2,
                      ),
                      rotav3: _selectedImmunizationType.contains(
                        ImmunizationType.rotav3,
                      ),
                      pcv1: _selectedImmunizationType.contains(
                        ImmunizationType.pcv1,
                      ),
                      pcv2: _selectedImmunizationType.contains(
                        ImmunizationType.pcv2,
                      ),
                      pcv3: _selectedImmunizationType.contains(
                        ImmunizationType.pcv3,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
