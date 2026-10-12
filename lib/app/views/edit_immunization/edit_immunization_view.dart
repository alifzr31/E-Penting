import 'package:e_penting/app/views/edit_immunization/widgets/edit_immunization_body.dart';
import 'package:flutter/material.dart';

class EditImmunizationView extends StatelessWidget {
  const new({required this.immunizationId, super.key});

  final int immunizationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Imunisasi')),
      body: EditImmunizationBody(immunizationId: immunizationId),
    );
  }
}
