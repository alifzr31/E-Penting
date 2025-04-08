import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/views/ortu/components/tumbuh_kembang/historypengukuran_card.dart';
import 'package:epenting/app/views/ortu/components/tumbuh_kembang/historypengukurancard_loading.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuKembangHistory extends StatelessWidget {
  const OrtuKembangHistory({super.key});

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
                  'Riwayat Pengukuran',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<OrtuCubit, OrtuState>(
                builder: (context, state) {
                  switch (state.historyPengukuranStatus) {
                    case HistoryPengukuranStatus.error:
                      return SizedBox(
                        height: 234.h,
                        width: double.infinity,
                        child: BaseErrorstate(
                          message: state.historyPengukuranError,
                          lottieWidth: 180.w,
                          showButton: false,
                        ),
                      );
                    case HistoryPengukuranStatus.success:
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.historyPengukurans.length,
                        itemBuilder: (context, index) {
                          final historyPengukuran =
                              state.historyPengukurans[index];

                          return HistoryPengukuranCard(
                            pengukuranDate:
                                historyPengukuran.tanggalUkur ?? DateTime(0000),
                            weight: historyPengukuran.berat ?? 0,
                            height: historyPengukuran.tinggi ?? 0,
                            index: index,
                            dataLength: state.historyPengukurans.length,
                          );
                        },
                      );
                    default:
                      return historyPengukuranCardLoading();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
