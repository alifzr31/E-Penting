import 'package:e_penting/app/views/edit_measurement/widgets/edit_measurement_body.dart';
import 'package:flutter/material.dart';

class EditMeasurementView extends StatelessWidget {
  const new({required this.measurementId, super.key});

  final int measurementId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Pengukuran')),
      body: EditMeasurementBody(measurementId: measurementId),
    );
  }
}
