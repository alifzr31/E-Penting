import 'package:e_penting/app/views/detail_guide/detail_guide_view.dart';
import 'package:flutter/material.dart';

class DetailGuidePage extends StatelessWidget {
  const new({required this.imageName, super.key});

  final String? imageName;

  @override
  Widget build(BuildContext context) {
    return DetailGuideView(imageName: imageName);
  }
}
