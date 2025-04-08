import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/history_pengukuran.dart';
import 'package:epenting/app/models/latest_pengukuran.dart';
import 'package:epenting/app/models/latest_vaccine.dart';
import 'package:epenting/app/models/profile.dart';
import 'package:epenting/app/repositories/ortu_repository.dart';
import 'package:equatable/equatable.dart';

part 'ortu_state.dart';

class OrtuCubit extends Cubit<OrtuState> {
  OrtuCubit(this._repository) : super(const OrtuState());

  final OrtuRepository _repository;

  void selectAnak(Anak? anak) async {
    if (state.selectedAnak == null) {
      emit(state.copyWith(selectedAnak: anak));

      await fetchLatestPengukuranBalita(nik: anak?.nik);
      await fetchLatestVaccine(nik: anak?.nik);
      await fetchHistoryPengukuran(nik: anak?.nik);
    } else {
      emit(state.copyWith(selectedAnak: anak));

      // REFETCH DATA
    }
  }

  Future<void> fetchLatestPengukuranBalita({String? nik}) async {
    emit(
      state.copyWith(latestPengukuranStatus: LatestPengukuranStatus.loading),
    );

    try {
      final latestPengukuranBalita = await _repository
          .fetchLatestPengukuranBalita(nik: nik);

      emit(
        state.copyWith(
          latestPengukuranStatus: LatestPengukuranStatus.success,
          latestPengukuran: latestPengukuranBalita,
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

  Future<void> fetchLatestVaccine({String? nik}) async {
    emit(
      state.copyWith(
        latestPengukuran: state.latestPengukuran,
        latestVaccineStatus: LatestVaccineStatus.loading,
      ),
    );

    try {
      final latestVaccines = await _repository.fetchLatestVaccine(nik: nik);

      emit(
        state.copyWith(
          latestPengukuran: state.latestPengukuran,
          latestVaccineStatus: LatestVaccineStatus.success,
          latestVaccines: latestVaccines,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          latestPengukuran: state.latestPengukuran,
          latestVaccineStatus: LatestVaccineStatus.error,
          latestVaccineError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  Future<void> fetchHistoryPengukuran({String? nik}) async {
    emit(
      state.copyWith(
        latestPengukuran: state.latestPengukuran,
        historyPengukuranStatus: HistoryPengukuranStatus.loading,
      ),
    );

    try {
      final historyPengukurans = await _repository.fetchHistoryPengukuran(
        nik: nik,
      );

      emit(
        state.copyWith(
          latestPengukuran: state.latestPengukuran,
          historyPengukuranStatus: HistoryPengukuranStatus.success,
          historyPengukurans: historyPengukurans,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          latestPengukuran: state.latestPengukuran,
          historyPengukuranStatus: HistoryPengukuranStatus.error,
          historyPengukuranError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
