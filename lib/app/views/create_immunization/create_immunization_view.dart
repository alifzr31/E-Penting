import 'package:e_penting/app/views/create_immunization/widgets/create_immunization_body.dart';
import 'package:flutter/material.dart';

class CreateImmunizationView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Imunisasi')),
      body: const CreateImmunizationBody(),
    );
  }
}
