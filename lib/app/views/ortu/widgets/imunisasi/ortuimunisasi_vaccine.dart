import 'package:epenting/app/cubits/ortu/ortu_cubit.dart';
import 'package:epenting/app/models/vaccine.dart';
import 'package:epenting/app/utils/app_helpers.dart';
import 'package:epenting/app/views/ortu/components/imunisasi/vaccine_card.dart';
import 'package:epenting/app/views/ortu/components/imunisasi/vaccinecard_loading.dart';
import 'package:epenting/app/widgets/base_errorstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrtuimunisasiVaccine extends StatelessWidget {
  const OrtuimunisasiVaccine({required this.vaccines, super.key});

  final List<Vaccine> vaccines;

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
                  'Imunisasi yang Sudah Dilakukan',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              BlocBuilder<OrtuCubit, OrtuState>(
                builder: (context, state) {
                  switch (state.latestVaccineStatus) {
                    case LatestVaccineStatus.error:
                      return BaseErrorstate(
                        message: state.latestVaccineError,
                        padding: const EdgeInsets.only(bottom: 10),
                      );
                    case LatestVaccineStatus.success:
                      final latestVaccine =
                          state.latestVaccines.isEmpty
                              ? const []
                              : state.latestVaccines.first.imunisasi?.map((e) {
                                return e
                                    .replaceAll(RegExp(r'[\s-]'), '')
                                    .toLowerCase();
                              }).toList();

                      return Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6.w,
                                  mainAxisSpacing: 6.h,
                                  childAspectRatio: 5.6,
                                ),
                            itemCount: vaccines.length,
                            itemBuilder: (context, index) {
                              final vaccine = vaccines[index];
                              final isMatch =
                                  latestVaccine?.contains(vaccine.id) ?? false;

                              return VaccineCard(
                                name: vaccine.name ?? '',
                                isMatch: isMatch,
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                'Terakhir Diperbarui :',
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    state.latestVaccines.isEmpty
                                        ? '-'
                                        : AppHelpers.dayMonthYearFormat(
                                          state
                                              .latestVaccines
                                              .first
                                              .tanggalImunisasi!,
                                        ),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    default:
                      return vaccineCardLoading(vaccines);
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
