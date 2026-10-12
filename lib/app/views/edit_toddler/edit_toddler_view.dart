import 'package:e_penting/app/views/edit_toddler/widgets/edit_toddler_body.dart';
import 'package:flutter/material.dart';

class EditToddlerView extends StatelessWidget {
  const new({required this.toddlerId, super.key});

  final int toddlerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Balita')),
      body: EditToddlerBody(toddlerId: toddlerId),
    );
  }
}
