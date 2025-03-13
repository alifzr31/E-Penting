import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/repositories/balita_repository.dart';
import 'package:equatable/equatable.dart';

part 'balita_state.dart';

class BalitaCubit extends Cubit<BalitaState> {
  BalitaCubit(this._repository) : super(const BalitaState());

  final BalitaRepository _repository;
  int currentPage = 1;

  Future<void> fetchAllBalita() async {
    if (currentPage == 1) {
      emit(state.copyWith(balitaStatus: BalitaStatus.loading));
    }

    try {
      final balitas = await _repository.fetchAllBalita(
        page: currentPage,
        ageFilter: state.selectedFilter,
      );

      if (balitas.length < 15) {
        emit(state.copyWith(hasMoreBalita: false));
      }

      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.success,
          balitas: List.of(state.balitas)..addAll(balitas),
        ),
      );
      currentPage++;
    } on DioException catch (e) {
      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.error,
          balitaError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchAllBalita({
    bool isSearch = false,
    String? filter,
    String? search,
  }) async {
    currentPage = 1;
    emit(
      state.copyWith(
        balitaStatus: BalitaStatus.initial,
        hasMoreBalita: true,
        balitas: const [],
        balitaError: null,
        selectedFilter: filter,
      ),
    );

    if (isSearch) {
      await fetchSearchBalita(name: search);
    } else {
      await fetchAllBalita();
    }
  }

  Future<void> fetchSearchBalita({String? name}) async {
    emit(state.copyWith(balitaStatus: BalitaStatus.loading));

    try {
      final balitas = await _repository.fetchSearchBalita(name: name);

      emit(
        state.copyWith(balitaStatus: BalitaStatus.success, balitas: balitas),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.error,
          balitaError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
