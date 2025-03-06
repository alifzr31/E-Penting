import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/repositories/pengukuran_repository.dart';
import 'package:equatable/equatable.dart';

part 'pengukuran_state.dart';

class PengukuranCubit extends Cubit<PengukuranState> {
  PengukuranCubit(this._repository) : super(const PengukuranState());

  final PengukuranRepository _repository;
  int currentPage = 1;

  Future<void> fetchAllPengukuran({int? month, int? year}) async {
    if (currentPage == 1) {
      emit(state.copyWith(pengukuranStatus: PengukuranStatus.loading));
    }

    try {
      final pengukurans = await _repository.fetchAllPengukuran(
        page: currentPage,
        month: month,
        year: year,
      );

      if (pengukurans.length < 15) {
        emit(state.copyWith(hasMorePengukuran: false));
      }

      emit(
        state.copyWith(
          pengukuranStatus: PengukuranStatus.success,
          pengukurans: List.of(state.pengukurans)..addAll(pengukurans),
        ),
      );
      currentPage++;
    } on DioException catch (e) {
      emit(
        state.copyWith(
          pengukuranStatus: PengukuranStatus.error,
          pengukuranError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchAllPengukuran({int? month, int? year}) async {
    currentPage = 1;
    emit(
      state.copyWith(
        pengukuranStatus: PengukuranStatus.initial,
        hasMorePengukuran: true,
        pengukurans: const [],
        pengukuranError: null,
      ),
    );

    await fetchAllPengukuran(month: month, year: year);
  }
}
