import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/measurement.dart';
import 'package:e_penting/app/models/measurement_detail.dart';
import 'package:e_penting/app/models/measurement_graph_nik.dart';
import 'package:e_penting/app/models/measurement_history_nik.dart';
import 'package:e_penting/app/repositories/measurement_repository.dart';
import 'package:equatable/equatable.dart';

part 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  new(this._repository) : super(const MeasurementState());

  final MeasurementRepository _repository;

  int _currentMeasurementPage = 1;

  Future<void> fetchAllParentData({String? nik}) async {
    await fetchHeightMeasurementGraphNik(nik: nik);
    await fetchWeightMeasurementGraphNik(nik: nik);
    await fetchMeasurementHistoryNik(nik: nik);
  }

  void refetchAllParentData({String? nik}) {
    refetchHeightMeasurementGraphNik(nik: nik);
    refetchWeightMeasurementGraphNik(nik: nik);
    refetchMeasurementHistoryNik(nik: nik);
  }

  Future<void> fetchMeasurementHistoryNik({String? nik}) async {
    emit(
      state.copyWith(
        heightMeasurementGraphNik: state.heightMeasurementGraphNik,
        heightMeasurementGraphNikErrorMessage:
            state.heightMeasurementGraphNikErrorMessage,
        weightMeasurementGraphNik: state.weightMeasurementGraphNik,
        weightMeasurementGraphNikErrorMessage:
            state.weightMeasurementGraphNikErrorMessage,
        measurementHistoryNikStatus: .loading,
      ),
    );

    try {
      final measurementHistoryNik = await _repository
          .fetchMeasurementHistoryNik(nik: nik);

      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNik: state.heightMeasurementGraphNik,
          heightMeasurementGraphNikErrorMessage:
              state.heightMeasurementGraphNikErrorMessage,
          weightMeasurementGraphNik: state.weightMeasurementGraphNik,
          weightMeasurementGraphNikErrorMessage:
              state.weightMeasurementGraphNikErrorMessage,
          measurementHistoryNikStatus: .success,
          measurementHistoryNik: measurementHistoryNik,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNik: state.heightMeasurementGraphNik,
          heightMeasurementGraphNikErrorMessage:
              state.heightMeasurementGraphNikErrorMessage,
          weightMeasurementGraphNik: state.weightMeasurementGraphNik,
          weightMeasurementGraphNikErrorMessage:
              state.weightMeasurementGraphNikErrorMessage,
          measurementHistoryNikStatus: .error,
          measurementHistoryNikErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchMeasurementHistoryNik({String? nik}) async {
    if (isClosed) return;

    emit(
      state.copyWith(
        heightMeasurementGraphNik: state.heightMeasurementGraphNik,
        heightMeasurementGraphNikErrorMessage:
            state.heightMeasurementGraphNikErrorMessage,
        weightMeasurementGraphNik: state.weightMeasurementGraphNik,
        weightMeasurementGraphNikErrorMessage:
            state.weightMeasurementGraphNikErrorMessage,
        measurementHistoryNikStatus: .success,
        measurementHistoryNik: null,
        measurementHistoryNikErrorMessage: null,
      ),
    );

    await fetchMeasurementHistoryNik(nik: nik);
  }

  Future<void> fetchHeightMeasurementGraphNik({String? nik}) async {
    emit(
      state.copyWith(
        heightMeasurementGraphNikStatus: .loading,
        weightMeasurementGraphNik: state.weightMeasurementGraphNik,
        weightMeasurementGraphNikErrorMessage:
            state.weightMeasurementGraphNikErrorMessage,
      ),
    );

    try {
      final heightMeasurementGraphNik = await _repository
          .fetchHeightMeasurementGraphNik(nik: nik);

      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNikStatus: .success,
          heightMeasurementGraphNik: heightMeasurementGraphNik,
          weightMeasurementGraphNik: state.weightMeasurementGraphNik,
          weightMeasurementGraphNikErrorMessage:
              state.weightMeasurementGraphNikErrorMessage,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNikStatus: .error,
          heightMeasurementGraphNikErrorMessage: e.toString(),
          weightMeasurementGraphNik: state.weightMeasurementGraphNik,
          weightMeasurementGraphNikErrorMessage:
              state.weightMeasurementGraphNikErrorMessage,
        ),
      );
    }
  }

  void refetchHeightMeasurementGraphNik({String? nik}) async {
    if (isClosed) return;

    emit(
      state.copyWith(
        heightMeasurementGraphNikStatus: .initial,
        heightMeasurementGraphNik: null,
        heightMeasurementGraphNikErrorMessage: null,
        weightMeasurementGraphNik: state.weightMeasurementGraphNik,
        weightMeasurementGraphNikErrorMessage:
            state.weightMeasurementGraphNikErrorMessage,
      ),
    );

    await fetchHeightMeasurementGraphNik(nik: nik);
  }

  Future<void> fetchWeightMeasurementGraphNik({String? nik}) async {
    emit(
      state.copyWith(
        heightMeasurementGraphNik: state.heightMeasurementGraphNik,
        heightMeasurementGraphNikErrorMessage:
            state.heightMeasurementGraphNikErrorMessage,
        weightMeasurementGraphNikStatus: .loading,
      ),
    );

    try {
      final weightMeasurementGraphNik = await _repository
          .fetchWeightMeasurementGraphNik(nik: nik);

      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNik: state.heightMeasurementGraphNik,
          heightMeasurementGraphNikErrorMessage:
              state.heightMeasurementGraphNikErrorMessage,
          weightMeasurementGraphNikStatus: .success,
          weightMeasurementGraphNik: weightMeasurementGraphNik,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          heightMeasurementGraphNik: state.heightMeasurementGraphNik,
          heightMeasurementGraphNikErrorMessage:
              state.heightMeasurementGraphNikErrorMessage,
          weightMeasurementGraphNikStatus: .error,
          weightMeasurementGraphNikErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchWeightMeasurementGraphNik({String? nik}) async {
    if (isClosed) return;

    emit(
      state.copyWith(
        heightMeasurementGraphNik: state.heightMeasurementGraphNik,
        heightMeasurementGraphNikErrorMessage:
            state.heightMeasurementGraphNikErrorMessage,
        weightMeasurementGraphNikStatus: .initial,
        weightMeasurementGraphNik: null,
        weightMeasurementGraphNikErrorMessage: null,
      ),
    );

    await fetchWeightMeasurementGraphNik(nik: nik);
  }

  Future<void> fetchLatestMeasurements() async {
    emit(state.copyWith(latestMeasurementsStatus: .loading));

    try {
      final latestMeasurements = await _repository.fetchLatestMeasurements();

      if (isClosed) return;

      emit(
        state.copyWith(
          latestMeasurementsStatus: .success,
          latestMeasurements: latestMeasurements,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          latestMeasurementsStatus: .error,
          latestMeasurementsError: e.toString(),
        ),
      );
    }
  }

  void refetchLatestMeasurements() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        latestMeasurementsStatus: .initial,
        latestMeasurements: const [],
        latestMeasurementsError: null,
      ),
    );

    await fetchLatestMeasurements();
  }

  Future<void> fetchMeasurements({int? month, int? year}) async {
    if (_currentMeasurementPage == 1) {
      emit(state.copyWith(measurementStatus: .loading));
    }

    try {
      final measurements = await _repository.fetchMeasurements(
        page: _currentMeasurementPage,
        month: month,
        year: year,
      );

      if (isClosed) return;

      if (measurements.length < 15) {
        emit(state.copyWith(hasMoreMeasurement: false));
      }

      emit(
        state.copyWith(
          measurementStatus: .success,
          measurements: List.of(state.measurements)..addAll(measurements),
        ),
      );
      _currentMeasurementPage++;
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          measurementStatus: .error,
          measurementErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchSearchMeasurements({String? keyword}) async {
    emit(state.copyWith(measurementStatus: .loading));

    try {
      final measurements = await _repository.fetchSearchMeasurements(
        keyword: keyword,
      );

      if (isClosed) return;

      emit(
        state.copyWith(measurementStatus: .success, measurements: measurements),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          measurementStatus: .error,
          measurementErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchMeasurements({String? keyword, int? month, int? year}) async {
    if (isClosed) return;

    if (keyword == null || keyword.isEmpty) {
      _currentMeasurementPage = 1;
      emit(
        state.copyWith(
          measurementStatus: .initial,
          measurements: const [],
          hasMoreMeasurement: true,
          measurementErrorMessage: null,
        ),
      );

      await fetchMeasurements(month: month, year: year);
    } else {
      _currentMeasurementPage = 1;
      emit(
        state.copyWith(
          measurementStatus: .initial,
          measurements: const [],
          hasMoreMeasurement: false,
          measurementErrorMessage: null,
        ),
      );

      await fetchSearchMeasurements(keyword: keyword);
    }
  }

  Future<void> fetchMeasurementDetail({int? measurementId}) async {
    emit(state.copyWith(measurementDetailStatus: .loading));

    try {
      final measurementDetail = await _repository.fetchMeasurementDetail(
        measurementId: measurementId,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          measurementDetailStatus: .success,
          measurementDetail: measurementDetail,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          measurementDetailStatus: .error,
          measurementDetailErrorMessage: e.toString(),
        ),
      );
    }
  }

  void createMeasurement({
    int? toddlerId,
    DateTime? measurementDate,
    String? measurementType,
    String? headCircumference,
    String? lila,
    String? height,
    String? weight,
    String? asiMonth0,
    String? asiMonth1,
    String? asiMonth2,
    String? asiMonth3,
    String? asiMonth4,
    String? asiMonth5,
    String? asiMonth6,
    String? givenVitA,
    String? givenVitANumber,
    bool? pittingEdema,
    int? degrees,
    bool? motherToddlerClass,
    bool? mbg,
  }) async {
    emit(state.copyWith(formStatus: .loading));

    try {
      final responseData = await _repository.createMeasurement(
        toddlerId: toddlerId,
        measurementDate: measurementDate,
        measurementType: measurementType,
        headCircumference: headCircumference,
        lila: lila,
        height: height,
        weight: weight,
        asiMonth0: asiMonth0,
        asiMonth1: asiMonth1,
        asiMonth2: asiMonth2,
        asiMonth3: asiMonth3,
        asiMonth4: asiMonth4,
        asiMonth5: asiMonth5,
        asiMonth6: asiMonth6,
        givenVitA: givenVitA,
        givenVitANumber: givenVitANumber,
        pittingEdema: pittingEdema,
        degrees: degrees,
        motherToddlerClass: motherToddlerClass,
        mbg: mbg,
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

  void editMeasurement({
    int? measurementId,
    int? toddlerId,
    DateTime? measurementDate,
    String? measurementType,
    String? headCircumference,
    String? lila,
    String? height,
    String? weight,
    String? asiMonth0,
    String? asiMonth1,
    String? asiMonth2,
    String? asiMonth3,
    String? asiMonth4,
    String? asiMonth5,
    String? asiMonth6,
    String? givenVitA,
    String? givenVitANumber,
    bool? pittingEdema,
    int? degrees,
    bool? motherToddlerClass,
    bool? mbg,
  }) async {
    emit(state.copyWith(formStatus: .loading));

    try {
      final responseData = await _repository.editMeasurement(
        measurementId: measurementId,
        toddlerId: toddlerId,
        measurementDate: measurementDate,
        measurementType: measurementType,
        headCircumference: headCircumference,
        lila: lila,
        height: height,
        weight: weight,
        asiMonth0: asiMonth0,
        asiMonth1: asiMonth1,
        asiMonth2: asiMonth2,
        asiMonth3: asiMonth3,
        asiMonth4: asiMonth4,
        asiMonth5: asiMonth5,
        asiMonth6: asiMonth6,
        givenVitA: givenVitA,
        givenVitANumber: givenVitANumber,
        pittingEdema: pittingEdema,
        degrees: degrees,
        motherToddlerClass: motherToddlerClass,
        mbg: mbg,
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

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
