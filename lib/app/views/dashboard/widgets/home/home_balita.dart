import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/utils/app_colors.dart';
import 'package:epenting/app/views/dashboard/components/home/balita_item.dart';
import 'package:epenting/app/views/dashboard/components/home/balitaitem_loading.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:epenting/app/widgets/base_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBalita extends StatelessWidget {
  const HomeBalita({this.seeAllBalita, super.key});

  final void Function()? seeAllBalita;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104,
      width: ScreenUtil().screenWidth,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Balita Terdata',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (context.watch<DashboardCubit>().state.latestBalitaStatus ==
                    LatestBalitaStatus.success)
                  BaseTextButton(
                    text: 'Lihat Semua',
                    size: 12.sp,
                    color: AppColors.orangeColor,
                    onPressed: seeAllBalita,
                  ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                switch (state.latestBalitaStatus) {
                  case LatestBalitaStatus.error:
                    return BaseHorizontalErrorState(
                      message: state.latestBalitaError,
                      messageSize: 12.sp,
                      lottieWidth: 86.w,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    );
                  case LatestBalitaStatus.success:
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.latestBalitas.length,
                      itemBuilder: (context, index) {
                        final balita = state.latestBalitas[index];

                        return BalitaItem(
                          age: balita.bulanUsia ?? 0,
                          name: balita.namaAnak ?? '',
                          gender: balita.jenisKelamin ?? '',
                          index: index,
                          dataLength: state.latestBalitas.length,
                          onTap: () {},
                        );
                      },
                    );
                  default:
                    return balitaItemLoading();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
