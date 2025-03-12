import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/repositories/imunisasi_repository.dart';
import 'package:equatable/equatable.dart';

part 'imunisasi_state.dart';

class ImunisasiCubit extends Cubit<ImunisasiState> {
  ImunisasiCubit(this._repository) : super(const ImunisasiState());

  final ImunisasiRepository _repository;
  int currentPage = 1;

  Future<void> fetchAllImunisasi({int? month, int? year}) async {
    if (currentPage == 1) {
      emit(state.copyWith(imunisasiStatus: ImunisasiStatus.loading));
    }

    try {
      final imunisasis = await _repository.fetchAllImunisasi(
        page: currentPage,
        month: month,
        year: year,
      );

      if (imunisasis.length < 15) {
        emit(state.copyWith(hasMoreImunisasi: false));
      }

      emit(
        state.copyWith(
          imunisasiStatus: ImunisasiStatus.success,
          imunisasis: List.of(state.imunisasis)..addAll(imunisasis),
        ),
      );
      currentPage++;
    } on DioException catch (e) {
      emit(
        state.copyWith(
          imunisasiStatus: ImunisasiStatus.error,
          imunisasiError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchAllImunisasi({
    bool isSearch = false,
    int? month,
    int? year,
    String? search,
  }) async {
    currentPage = 1;
    emit(
      state.copyWith(
        imunisasiStatus: ImunisasiStatus.initial,
        hasMoreImunisasi: true,
        imunisasis: const [],
        imunisasiError: null,
      ),
    );

    if (isSearch) {
      await fetchSearchImunisasi(name: search);
    } else {
      await fetchAllImunisasi(month: month, year: year);
    }
  }

  Future<void> fetchSearchImunisasi({String? name}) async {
    emit(state.copyWith(imunisasiStatus: ImunisasiStatus.loading));

    try {
      final imunisasis = await _repository.fetchSearchImunisasi(name: name);

      emit(
        state.copyWith(
          imunisasiStatus: ImunisasiStatus.success,
          imunisasis: imunisasis,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          imunisasiStatus: ImunisasiStatus.error,
          imunisasiError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
