import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/detail_pengukuran.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/repositories/pengukuran_repository.dart';
import 'package:equatable/equatable.dart';

part 'pengukuran_state.dart';

class PengukuranCubit extends Cubit<PengukuranState> {
  PengukuranCubit(this._repository) : super(const PengukuranState());

  final PengukuranRepository _repository;
  int currentPage = 1;

  void resetState() {
    emit(
      state.copyWith(
        pengukuranStatus: PengukuranStatus.initial,
        hasMorePengukuran: true,
        pengukurans: const [],
        pengukuranError: null,
        formStatus: FormStatus.initial,
        formResponse: null,
        formError: null,
      ),
    );
  }

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

  void refetchAllPengukuran({
    bool isSearch = false,
    int? month,
    int? year,
    String? search,
  }) async {
    currentPage = 1;
    emit(
      state.copyWith(
        pengukuranStatus: PengukuranStatus.initial,
        hasMorePengukuran: true,
        pengukurans: const [],
        pengukuranError: null,
      ),
    );

    if (isSearch) {
      await fetchSearchPengukuran(name: search);
    } else {
      await fetchAllPengukuran(month: month, year: year);
    }
  }

  Future<void> fetchSearchPengukuran({String? name}) async {
    emit(state.copyWith(pengukuranStatus: PengukuranStatus.loading));

    try {
      final pengukurans = await _repository.fetchSearchPengukuran(name: name);

      emit(
        state.copyWith(
          pengukuranStatus: PengukuranStatus.success,
          pengukurans: pengukurans,
        ),
      );
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

  void resetAddFormState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          formStatus: FormStatus.initial,
          formResponse: null,
          formError: null,
        ),
      );
    });
  }

  void addPengukuran({
    String? tglPengukuran,
    int? idBalita,
    String? caraPengukuran,
    String? beratBadan,
    String? tinggiBadan,
    String? lila,
    String? lingkarKepala,
    List<String>? selectedAsi,
    String? pemberianVitA,
    String? jumlahPemberian,
    String? pittingEdema,
    int? derajat,
    String? kelasIbuBalita,
  }) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    try {
      final response = await _repository.addPengukuran(
        tglPengukuran: tglPengukuran,
        idBalita: idBalita,
        caraPengukuran: caraPengukuran,
        beratBadan: beratBadan,
        tinggiBadan: tinggiBadan,
        lila: lila,
        lingkarKepala: lingkarKepala,
        selectedAsi: selectedAsi,
        pemberianVitA: pemberianVitA,
        jumlahPemberian: jumlahPemberian,
        pittingEdema: pittingEdema,
        derajat: derajat,
        kelasIbuBalita: kelasIbuBalita,
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
          detailPengukuran: null,
          detailError: null,
          formStatus: FormStatus.initial,
          formResponse: null,
          formError: null,
        ),
      );
    });
  }

  Future<void> fetchDetailPengukuran({int? idPengukuran}) async {
    emit(state.copyWith(detailStatus: DetailStatus.loading));

    try {
      final detailPengukuran = await _repository.fetchDetailPengukuran(
        idPengukuran: idPengukuran,
      );

      emit(
        state.copyWith(
          detailStatus: DetailStatus.success,
          detailPengukuran: detailPengukuran,
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

  void editPengukuran({
    int? idPengukuran,
    String? tglPengukuran,
    int? idBalita,
    String? caraPengukuran,
    String? beratBadan,
    String? tinggiBadan,
    String? lila,
    String? lingkarKepala,
    List<String>? selectedAsi,
    String? pemberianVitA,
    String? jumlahPemberian,
    String? pittingEdema,
    int? derajat,
    String? kelasIbuBalita,
  }) async {
    emit(
      state.copyWith(
        detailPengukuran: state.detailPengukuran,
        formStatus: FormStatus.loading,
      ),
    );

    try {
      final response = await _repository.editPengukuran(
        idPengukuran: idPengukuran,
        tglPengukuran: tglPengukuran,
        idBalita: idBalita,
        caraPengukuran: caraPengukuran,
        beratBadan: beratBadan,
        tinggiBadan: tinggiBadan,
        lila: lila,
        lingkarKepala: lingkarKepala,
        selectedAsi: selectedAsi,
        pemberianVitA: pemberianVitA,
        jumlahPemberian: jumlahPemberian,
        pittingEdema: pittingEdema,
        derajat: derajat,
        kelasIbuBalita: kelasIbuBalita,
      );

      emit(
        state.copyWith(
          detailPengukuran: state.detailPengukuran,
          formStatus: FormStatus.success,
          formResponse: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailPengukuran: state.detailPengukuran,
          formStatus: FormStatus.error,
          formError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
