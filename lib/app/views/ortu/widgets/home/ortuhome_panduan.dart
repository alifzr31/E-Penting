import 'package:epenting/app/views/detail_panduan/detailpanduan_page.dart';
import 'package:epenting/app/views/ortu/components/home/panduan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuHomePanduan extends StatelessWidget {
  const OrtuHomePanduan({required this.panduans, super.key});

  final List<String> panduans;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Panduan Perawatan Anak',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Berdasarkan Buku KIA (Kesehatan Ibu dan Anak)\nKementrian Kesehatan Tahun 2023',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 182.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: panduans.length,
            itemBuilder: (context, index) {
              return PanduanCard(
                ageRange: panduans[index],
                index: index,
                dataLength: panduans.length,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailPanduanPage.routeName,
                    arguments: {
                      'imageName': '${panduans[index].toLowerCase()}.jpg',
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
