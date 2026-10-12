import 'package:e_penting/app/configs/router/route_name.dart';
import 'package:e_penting/app/views/dashboard/components/parent/home/guide_card.dart';
import 'package:flutter/material.dart';

class ParentGuideSection extends StatelessWidget {
  const new({required this.guides, super.key});

  final List<String> guides;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Align(
            alignment: .centerLeft,
            child: Padding(
              padding: const .symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const Text(
                    'Panduan Perawatan Anak',
                    style: TextStyle(fontSize: 16, fontWeight: .w600),
                  ),
                  Text(
                    'Berdasarkan Buku KIA (Kesehatan Ibu dan Anak) Kementrian Kesehatan RI Tahun 2023',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            width: .infinity,
            margin: const .only(bottom: 16),
            child: ListView.builder(
              scrollDirection: .horizontal,
              padding: const .symmetric(horizontal: 16),
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];

                return GuideCard(
                  guide: guide,
                  dataLength: guides.length,
                  index: index,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.detailGuide,
                      arguments: '${guide.toLowerCase()}.jpg',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
