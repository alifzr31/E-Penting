import 'package:e_penting/app/views/create_measurement/widgets/create_measurement_body.dart';
import 'package:flutter/material.dart';

class CreateMeasurementView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengukuran')),
      body: const CreateMeasurementBody(),
    );
  }
}
