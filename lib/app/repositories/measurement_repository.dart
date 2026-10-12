import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/measurement_detail.dart';
import 'package:e_penting/app/models/measurement.dart';
import 'package:e_penting/app/models/measurement_graph_nik.dart';
import 'package:e_penting/app/models/measurement_history_nik.dart';
import 'package:e_penting/app/services/measurement_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class MeasurementRepository {
  Future<List<MeasurementHistoryNik>> fetchMeasurementHistoryNik({String? nik});
  Future<MeasurementGraphNik?> fetchHeightMeasurementGraphNik({String? nik});
  Future<MeasurementGraphNik?> fetchWeightMeasurementGraphNik({String? nik});
  Future<List<Measurement>> fetchLatestMeasurements();
  Future<List<Measurement>> fetchMeasurements({
    int? page,
    int? month,
    int? year,
  });
  Future<List<Measurement>> fetchSearchMeasurements({String? keyword});
  Future<MeasurementDetail?> fetchMeasurementDetail({int? measurementId});
  Future<Map<String, dynamic>?> createMeasurement({
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
  });
  Future<Map<String, dynamic>?> editMeasurement({
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
  });
  void cancelAllRequests();
}

class MeasurementRepositoryImpl implements MeasurementRepository {
  final MeasurementService _service;

  new(this._service);

  @override
  Future<List<MeasurementHistoryNik>> fetchMeasurementHistoryNik({
    String? nik,
  }) async {
    try {
      return await _service.fetchMeasurementHistoryNik(nik: nik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<MeasurementGraphNik?> fetchHeightMeasurementGraphNik({
    String? nik,
  }) async {
    try {
      return await _service.fetchHeightMeasurementGraphNik(nik: nik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<MeasurementGraphNik?> fetchWeightMeasurementGraphNik({
    String? nik,
  }) async {
    try {
      return await _service.fetchWeightMeasurementGraphNik(nik: nik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Measurement>> fetchLatestMeasurements() async {
    try {
      return await _service.fetchLatestMeasurements();
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Measurement>> fetchMeasurements({
    int? page,
    int? month,
    int? year,
  }) async {
    try {
      return await _service.fetchMeasurements(
        page: page,
        month: month,
        year: year,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Measurement>> fetchSearchMeasurements({String? keyword}) async {
    try {
      return await _service.fetchSearchMeasurements(keyword: keyword);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<MeasurementDetail?> fetchMeasurementDetail({
    int? measurementId,
  }) async {
    try {
      return await _service.fetchMeasurementDetail(
        measurementId: measurementId,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> createMeasurement({
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
    try {
      return await _service.createMeasurement(
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
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> editMeasurement({
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
    try {
      return await _service.editMeasurement(
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
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  void cancelAllRequests() {
    return _service.cancelAllRequests();
  }
}
