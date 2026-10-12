import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/immunization.dart';
import 'package:e_penting/app/models/immunization_detail.dart';
import 'package:e_penting/app/models/immunization_history_nik.dart';
import 'package:e_penting/app/repositories/immunization_repository.dart';
import 'package:equatable/equatable.dart';

part 'immunization_state.dart';

class ImmunizationCubit extends Cubit<ImmunizationState> {
  new(this._repository) : super(const ImmunizationState());

  final ImmunizationRepository _repository;

  int _currentImmunizationPage = 1;

  Future<void> fetchImmunizationHistoryNik({String? nik}) async {
    emit(state.copyWith(immunizationHistoryNikStatus: .loading));

    try {
      final immunizationHistoriesNik = await _repository
          .fetchImmunizationHistoryNik(nik: nik);

      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationHistoryNikStatus: .success,
          immunizationHistoriesNik: immunizationHistoriesNik,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationHistoryNikStatus: .error,
          immunizationHistoryNikErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchImmunizationHistoryNik({String? nik}) async {
    if (isClosed) return;

    emit(
      state.copyWith(
        immunizationHistoryNikStatus: .initial,
        immunizationHistoriesNik: const [],
        immunizationHistoryNikErrorMessage: null,
      ),
    );

    await fetchImmunizationHistoryNik(nik: nik);
  }

  Future<void> fetchLatestImmunizations() async {
    emit(state.copyWith(latestImmunizationStatus: .loading));

    try {
      final latestImmunizations = await _repository.fetchLatestImmunizations();

      if (isClosed) return;

      emit(
        state.copyWith(
          latestImmunizationStatus: .success,
          latestImmunizations: latestImmunizations,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          latestImmunizationStatus: .error,
          latestImmunizationErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchLatestImmunizations() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        latestImmunizationStatus: .initial,
        latestImmunizations: const [],
        latestImmunizationErrorMessage: null,
      ),
    );

    await fetchLatestImmunizations();
  }

  Future<void> fetchImmunizations({int? month, int? year}) async {
    if (_currentImmunizationPage == 1) {
      emit(state.copyWith(immunizationStatus: .loading));
    }

    try {
      final immunizations = await _repository.fetchImmunizations(
        page: _currentImmunizationPage,
        month: month,
        year: year,
      );

      if (isClosed) return;

      if (immunizations.length < 15) {
        emit(state.copyWith(hasMoreImmunization: false));
      }

      emit(
        state.copyWith(
          immunizationStatus: .success,
          immunizations: List.of(state.immunizations)..addAll(immunizations),
        ),
      );
      _currentImmunizationPage++;
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationStatus: .error,
          immunizationErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchSearchImmunizations({String? keyword}) async {
    emit(state.copyWith(immunizationStatus: .loading));

    try {
      final immunizations = await _repository.fetchSearchImmunizations(
        keyword: keyword,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationStatus: .success,
          immunizations: immunizations,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationStatus: .error,
          immunizationErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchImmunizations({String? keyword, int? month, int? year}) async {
    if (isClosed) return;

    if (keyword == null || keyword.isEmpty) {
      _currentImmunizationPage = 1;
      emit(
        state.copyWith(
          immunizationStatus: .initial,
          immunizations: const [],
          hasMoreImmunization: true,
          immunizationErrorMessage: null,
        ),
      );

      await fetchImmunizations(month: month, year: year);
    } else {
      _currentImmunizationPage = 1;
      emit(
        state.copyWith(
          immunizationStatus: .initial,
          immunizations: const [],
          hasMoreImmunization: false,
          immunizationErrorMessage: null,
        ),
      );

      await fetchSearchImmunizations(keyword: keyword);
    }
  }

  Future<void> fetchImmunizationDetail({int? immunizationId}) async {
    emit(state.copyWith(immunizationDetailStatus: .loading));

    try {
      final immunizationDetail = await _repository.fetchImmunizationDetail(
        immunizationId: immunizationId,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationDetailStatus: .success,
          immunizationDetail: immunizationDetail,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationDetailStatus: .error,
          immunizationDetailErrorMessage: e.toString(),
        ),
      );
    }
  }

  void createImmunization({
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  }) async {
    emit(state.copyWith(formStatus: .loading));

    try {
      final responseData = await _repository.createImmunization(
        toddlerId: toddlerId,
        immunizationDate: immunizationDate,
        hb: hb,
        dptHb1: dptHb1,
        dptHb2: dptHb2,
        dptHb3: dptHb3,
        dptHbl: dptHbl,
        polio1: polio1,
        polio2: polio2,
        polio3: polio3,
        polio4: polio4,
        campak: campak,
        campakL: campakL,
        bcg: bcg,
        ipv1: ipv1,
        ipv2: ipv2,
        rotav1: rotav1,
        rotav2: rotav2,
        rotav3: rotav3,
        pcv1: pcv1,
        pcv2: pcv2,
        pcv3: pcv3,
      );

      if (isClosed || responseData == null) return;

      emit(
        state.copyWith(formStatus: .success, formResponseData: responseData),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(state.copyWith(formStatus: .error, formErrorMessage: e.toString()));
    }
  }

  void editImmunization({
    int? immunizationId,
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  }) async {
    emit(
      state.copyWith(
        immunizationDetail: state.immunizationDetail,
        formStatus: .loading,
      ),
    );

    try {
      final responseData = await _repository.editImmunization(
        immunizationId: immunizationId,
        toddlerId: toddlerId,
        immunizationDate: immunizationDate,
        hb: hb,
        dptHb1: dptHb1,
        dptHb2: dptHb2,
        dptHb3: dptHb3,
        dptHbl: dptHbl,
        polio1: polio1,
        polio2: polio2,
        polio3: polio3,
        polio4: polio4,
        campak: campak,
        campakL: campakL,
        bcg: bcg,
        ipv1: ipv1,
        ipv2: ipv2,
        rotav1: rotav1,
        rotav2: rotav2,
        rotav3: rotav3,
        pcv1: pcv1,
        pcv2: pcv2,
        pcv3: pcv3,
      );

      if (isClosed || responseData == null) return;

      emit(
        state.copyWith(
          immunizationDetail: state.immunizationDetail,
          formStatus: .success,
          formResponseData: responseData,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          immunizationDetail: state.immunizationDetail,
          formStatus: .error,
          formErrorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
