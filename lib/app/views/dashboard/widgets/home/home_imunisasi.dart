import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/dashboard/components/imunisasi_card.dart';
import 'package:epenting/app/views/dashboard/components/imunisasicard_loading.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeImunisasi extends StatelessWidget {
  const HomeImunisasi({this.seeAllImunisasi, super.key});

  final void Function()? seeAllImunisasi;

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
                  'Imunisasi Terakhir',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  switch (state.latestImunisasiStatus) {
                    case LatestImunisasiStatus.error:
                      return Center(child: Text(state.latestImunisasiError));
                    case LatestImunisasiStatus.success:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.latestImunisasis.length,
                        itemBuilder: (context, index) {
                          final imunisasi = state.latestImunisasis[index];

                          return ImunisasiCard(
                            day: imunisasi.hari ?? '',
                            date: imunisasi.tanggalImunisasi ?? '',
                            name: imunisasi.namaAnak ?? '',
                            cardColor: Colors.grey.shade200,
                            elevation: 0,
                            marginBottom: 6,
                            index: index,
                            dataLength: state.latestImunisasis.length,
                            onTap: () {},
                          );
                        },
                      );
                    default:
                      return imunisasiCardLoading(
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
                onPressed: seeAllImunisasi,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
