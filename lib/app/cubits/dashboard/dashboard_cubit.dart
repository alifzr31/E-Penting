import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/models/percentage.dart';
import 'package:epenting/app/repositories/dashboard_repository.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._repository) : super(const DashboardState());

  final DashboardRepository _repository;

  void resetState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          greeting: '',
          percentageStatus: PercentageStatus.initial,
          percentages: const [],
          percentageError: null,
          latestBalitaStatus: LatestBalitaStatus.initial,
          latestBalitas: const [],
          latestBalitaError: null,
          latestPengukuranStatus: LatestPengukuranStatus.initial,
          latestPengukurans: const [],
          latestPengukuranError: null,
          latestImunisasiStatus: LatestImunisasiStatus.initial,
          latestImunisasis: const [],
          latestImunisasiError: null,
        ),
      );
    });
  }

  void loadData() async {
    await fetchPercentage();
    await fetchLatestBalita();
    await fetchLatestPengukuran();
    await fetchLatestImunisasi();
  }

  void startGreeting() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      int hour = DateTime.now().hour;

      if (hour >= 4 && hour < 11) {
        emit(state.copyWith(greeting: 'Enjing'));
      } else if (hour >= 11 && hour < 15) {
        emit(state.copyWith(greeting: 'Siang'));
      } else if (hour >= 15 && hour < 18) {
        emit(state.copyWith(greeting: 'Sonten'));
      } else {
        emit(state.copyWith(greeting: 'Wengi'));
      }
    });
  }

  Future<void> fetchPercentage() async {
    emit(state.copyWith(percentageStatus: PercentageStatus.loading));

    try {
      final percentages = await _repository.fetchPercentage();

      emit(
        state.copyWith(
          percentageStatus: PercentageStatus.success,
          percentages: percentages,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          percentageStatus: PercentageStatus.error,
          percentageError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchPercentage() async {
    emit(
      state.copyWith(
        percentageStatus: PercentageStatus.initial,
        percentages: const [],
        percentageError: null,
      ),
    );

    await fetchPercentage();
  }

  Future<void> fetchLatestBalita() async {
    emit(state.copyWith(latestBalitaStatus: LatestBalitaStatus.loading));

    try {
      final latestBalitas = await _repository.fetchLatestBalita();

      emit(
        state.copyWith(
          latestBalitaStatus: LatestBalitaStatus.success,
          latestBalitas: latestBalitas,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          latestBalitaStatus: LatestBalitaStatus.error,
          latestBalitaError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchLatestBalita() async {
    emit(
      state.copyWith(
        latestBalitaStatus: LatestBalitaStatus.initial,
        latestBalitas: const [],
        latestBalitaError: null,
      ),
    );

    await fetchLatestBalita();
  }

  Future<void> fetchLatestPengukuran() async {
    emit(
      state.copyWith(latestPengukuranStatus: LatestPengukuranStatus.loading),
    );

    try {
      final latestPengukurans = await _repository.fetchLatestPengukuran();

      emit(
        state.copyWith(
          latestPengukuranStatus: LatestPengukuranStatus.success,
          latestPengukurans: latestPengukurans,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          latestPengukuranStatus: LatestPengukuranStatus.error,
          latestPengukuranError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchLatestPengukuran() async {
    emit(
      state.copyWith(
        latestPengukuranStatus: LatestPengukuranStatus.initial,
        latestPengukurans: const [],
        latestPengukuranError: null,
      ),
    );

    await fetchLatestPengukuran();
  }

  Future<void> fetchLatestImunisasi() async {
    emit(state.copyWith(latestImunisasiStatus: LatestImunisasiStatus.loading));

    try {
      final latestImunisasis = await _repository.fetchLatestImunisasi();

      emit(
        state.copyWith(
          latestImunisasiStatus: LatestImunisasiStatus.success,
          latestImunisasis: latestImunisasis,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          latestImunisasiStatus: LatestImunisasiStatus.error,
          latestImunisasiError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchLatestImunisasi() async {
    emit(
      state.copyWith(
        latestImunisasiStatus: LatestImunisasiStatus.initial,
        latestImunisasis: const [],
        latestImunisasiError: null,
      ),
    );

    await fetchLatestImunisasi();
  }
}
