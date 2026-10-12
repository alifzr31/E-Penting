import 'package:e_penting/app/views/create_toddler/widgets/create_toddler_body.dart';
import 'package:flutter/material.dart';

class CreateToddlerView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Balita')),
      body: const CreateToddlerBody(),
    );
  }
}
