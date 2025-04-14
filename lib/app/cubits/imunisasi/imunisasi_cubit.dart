import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/detail_imunisasi.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/repositories/imunisasi_repository.dart';
import 'package:equatable/equatable.dart';

part 'imunisasi_state.dart';

class ImunisasiCubit extends Cubit<ImunisasiState> {
  ImunisasiCubit(this._repository) : super(const ImunisasiState());

  final ImunisasiRepository _repository;
  int currentPage = 1;

  void resetState() {
    emit(
      state.copyWith(
        imunisasiStatus: ImunisasiStatus.initial,
        hasMoreImunisasi: true,
        imunisasis: const [],
        imunisasiError: null,
      ),
    );
  }

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

  void resetAddFormState() {
    emit(
      state.copyWith(
        formStatus: FormStatus.initial,
        formResponse: null,
        formError: null,
      ),
    );
  }

  void addImunisasi({
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    try {
      final response = await _repository.addImunisasi(
        idBalita: idBalita,
        tglImunisasi: tglImunisasi,
        selectedVaccine: selectedVaccine,
      );

      emit(
        state.copyWith(formStatus: FormStatus.success, formResponse: response),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          formError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void resetEditFormState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          detailStatus: DetailStatus.initial,
          detailImunisasi: null,
          detailError: null,
          formStatus: FormStatus.initial,
          formResponse: null,
          formError: null,
        ),
      );
    });
  }

  Future<void> fetchDetailImunisasi({int? idImunisasi}) async {
    emit(state.copyWith(detailStatus: DetailStatus.loading));

    try {
      final detailImunisasi = await _repository.fetchDetailImunisasi(
        idImunisasi: idImunisasi,
      );

      emit(
        state.copyWith(
          detailStatus: DetailStatus.success,
          detailImunisasi: detailImunisasi,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailStatus: DetailStatus.error,
          detailError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void editImunisasi({
    int? idImunisasi,
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    emit(
      state.copyWith(
        detailImunisasi: state.detailImunisasi,
        formStatus: FormStatus.loading,
      ),
    );

    try {
      final response = await _repository.editImunisasi(
        idImunisasi: idImunisasi,
        idBalita: idBalita,
        tglImunisasi: tglImunisasi,
        selectedVaccine: selectedVaccine,
      );

      emit(
        state.copyWith(
          detailImunisasi: state.detailImunisasi,
          formStatus: FormStatus.success,
          formResponse: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailImunisasi: state.detailImunisasi,
          formStatus: FormStatus.error,
          formError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
