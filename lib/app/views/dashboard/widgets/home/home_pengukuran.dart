import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/dashboard/components/pengukuran_card.dart';
import 'package:epenting/app/views/dashboard/components/pengukurancard_loading.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePengukuran extends StatelessWidget {
  const HomePengukuran({this.seeAllPengukuran, super.key});
  final void Function()? seeAllPengukuran;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.white,
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pengukuran Terakhir',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  switch (state.latestPengukuranStatus) {
                    case LatestPengukuranStatus.error:
                      return Center(child: Text(state.latestPengukuranError));
                    case LatestPengukuranStatus.success:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.latestPengukurans.length,
                        itemBuilder: (context, index) {
                          final pengukuran = state.latestPengukurans[index];

                          return PengukuranCard(
                            day: pengukuran.hari ?? '',
                            measureDate: pengukuran.tanggalPenimbangan ?? '',
                            name: pengukuran.namaAnak ?? '',
                            stanting: pengukuran.stanting ?? '',
                            cardColor: Colors.grey.shade200,
                            elevation: 0,
                            marginBottom: 6,
                            index: index,
                            dataLength: state.latestPengukurans.length,
                            onTap: () {},
                          );
                        },
                      );
                    default:
                      return pengukuranCardLoading(
                        5,
                        shrinkWrap: true,
                        withPadding: false,
                        shimmerColor: const Color(0xFFFAFAFA),
                        cardColor: Colors.grey.shade200,
                        elevation: 0,
                        marginBottom: 6,
                      );
                  }
                },
              ),
              SizedBox(height: 8.h),
              BaseTextButton(
                text: 'Lihat Semua',
                size: 12.sp,
                color: AppColors.orangeColor,
                onPressed: seeAllPengukuran,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
