import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/measurement_detail.dart';
import 'package:e_penting/app/models/measurement.dart';
import 'package:e_penting/app/models/measurement_graph_nik.dart';
import 'package:e_penting/app/models/measurement_history_nik.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:flutter/foundation.dart';

class MeasurementService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<List<MeasurementHistoryNik>> fetchMeasurementHistoryNik({
    String? nik,
  }) async {
    final key = 'measurement_history_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/history',
        queryParams: {'nik': nik},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null
            ? const []
            : listMeasurementHistoryNikFromJson(message),
        response.data['data']['pengukuran'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<MeasurementGraphNik?> fetchHeightMeasurementGraphNik({
    String? nik,
  }) async {
    final key = 'height_measurement_graph_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/chart/tinggi',
        queryParams: {'nik': nik},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => measurementGraphNikFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<MeasurementGraphNik?> fetchWeightMeasurementGraphNik({
    String? nik,
  }) async {
    final key = 'weight_measurement_graph_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/chart/berat',
        queryParams: {'nik': nik},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => measurementGraphNikFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Measurement>> fetchLatestMeasurements() async {
    final key = 'latest_measurements';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/latest',
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => listMeasurementFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Measurement>> fetchMeasurements({
    int? page,
    int? month,
    int? year,
  }) async {
    final key = 'measurements';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/list',
        queryParams: {'page': page, 'month': ?month, 'year': ?year},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listMeasurementFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Measurement>> fetchSearchMeasurements({String? keyword}) async {
    final key = 'search_measurements';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/search',
        queryParams: {'name': keyword},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listMeasurementFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<MeasurementDetail?> fetchMeasurementDetail({
    int? measurementId,
  }) async {
    final key = 'detail_measurement';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/penimbangan/detail',
        queryParams: {'id_penimbangan': measurementId},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? null : measurementDetailFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

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
    final key = 'create_measurement';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/penimbangan',
        cancelToken: cancelToken,
        data: {
          "id_identitas": toddlerId,
          "tanggal_ukur": measurementDate?.formDataFormat(),
          "cara_ukur": measurementType,
          "lingkar_kepala": ?headCircumference,
          "lila": ?lila,
          "tinggi": height,
          "berat": weight,
          "asi_bulan_0": ?asiMonth0,
          "asi_bulan_1": ?asiMonth1,
          "asi_bulan_2": ?asiMonth2,
          "asi_bulan_3": ?asiMonth3,
          "asi_bulan_4": ?asiMonth4,
          "asi_bulan_5": ?asiMonth5,
          "asi_bulan_6": ?asiMonth6,
          "vitamin_a": givenVitA,
          "pemberian_ke": givenVitA == 'ya' ? givenVitANumber : 0,
          "pitting_edema": (pittingEdema ?? false) ? degrees : 4,
          "kelas_ibu_balita": motherToddlerClass,
          "mbg": mbg,
        },
      );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

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
    final key = 'edit_measurement';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.patch(
        '/penimbangan',
        cancelToken: cancelToken,
        queryParams: {'id_pengukuran': measurementId},
        data: {
          "id_identitas": toddlerId,
          "tanggal_ukur": measurementDate?.formDataFormat(),
          "cara_ukur": measurementType,
          "lingkar_kepala": ?headCircumference,
          "lila": ?lila,
          "tinggi": height,
          "berat": weight,
          "asi_bulan_0": ?asiMonth0,
          "asi_bulan_1": ?asiMonth1,
          "asi_bulan_2": ?asiMonth2,
          "asi_bulan_3": ?asiMonth3,
          "asi_bulan_4": ?asiMonth4,
          "asi_bulan_5": ?asiMonth5,
          "asi_bulan_6": ?asiMonth6,
          "vitamin_a": givenVitA,
          "pemberian_ke": givenVitA == 'ya' ? givenVitANumber : 0,
          "pitting_edema": (pittingEdema ?? false) ? degrees : 4,
          "kelas_ibu_balita": motherToddlerClass,
          "mbg": mbg,
        },
      );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  void cancelAllRequests() {
    DioHelper.removeAllCancelToken(_cancelTokens);
  }
}
