import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/immunization.dart';
import 'package:e_penting/app/models/immunization_detail.dart';
import 'package:e_penting/app/models/immunization_history_nik.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:flutter/foundation.dart';

class ImmunizationService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<List<ImmunizationHistoryNik>> fetchImmunizationHistoryNik({
    String? nik,
  }) async {
    final key = 'immunization_history_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/imunisasi/history-nik',
        queryParams: {'nik': nik},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null
            ? const []
            : listImmunizationHistoryNikFromJson(message),
        response.data['data']['list_imunisasi'],
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

  Future<List<Immunization>> fetchLatestImmunizations() async {
    final key = 'latest_immunizations';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/imunisasi/latest',
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listImmunizationFromJson(message),
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

  Future<List<Immunization>> fetchImmunizations({
    int? page,
    int? month,
    int? year,
  }) async {
    final key = 'immunizations';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/imunisasi/list',
        queryParams: {'page': page, 'month': ?month, 'year': ?year},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listImmunizationFromJson(message),
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

  Future<List<Immunization>> fetchSearchImmunizations({String? keyword}) async {
    final key = 'search_immunizations';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/imunisasi/search',
        queryParams: {'name': keyword},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listImmunizationFromJson(message),
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

  Future<ImmunizationDetail?> fetchImmunizationDetail({
    int? immunizationId,
  }) async {
    final key = 'detail_immunization';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/imunisasi/detail',
        queryParams: {'id_imunisasi': immunizationId},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? null : immunizationDetailFromJson(message),
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

  Future<Map<String, dynamic>?> createImmunization({
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
    final key = 'create_immunization';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/imunisasi',
        data: {
          'id_identitas': toddlerId,
          'tanggal_imunisasi': immunizationDate?.formDataFormat(),
          'hb': hb,
          'dpt_hb1': dptHb1,
          'dpt_hb2': dptHb2,
          'dpt_hb3': dptHb3,
          'dpt_hbl': dptHbl,
          'polio1': polio1,
          'polio2': polio2,
          'polio3': polio3,
          'polio4': polio4,
          'campak': campak,
          'campak_l': campakL,
          'bcg': bcg,
          'ipv_1': ipv1,
          'ipv_2': ipv2,
          'rotav_1': rotav1,
          'rotav_2': rotav2,
          'rotav_3': rotav3,
          'pcv_1': pcv1,
          'pcv_2': pcv2,
          'pcv_3': pcv3,
        },
        cancelToken: cancelToken,
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

  Future<Map<String, dynamic>?> editImmunization({
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
    final key = 'edit_immunization';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.patch(
        '/imunisasi',
        queryParams: {'id_imunisasi': immunizationId},
        data: {
          'id_identitas': toddlerId,
          'tanggal_imunisasi': immunizationDate?.formDataFormat(),
          'hb': hb,
          'dpt_hb1': dptHb1,
          'dpt_hb2': dptHb2,
          'dpt_hb3': dptHb3,
          'dpt_hbl': dptHbl,
          'polio1': polio1,
          'polio2': polio2,
          'polio3': polio3,
          'polio4': polio4,
          'campak': campak,
          'campak_l': campakL,
          'bcg': bcg,
          'ipv_1': ipv1,
          'ipv_2': ipv2,
          'rotav_1': rotav1,
          'rotav_2': rotav2,
          'rotav_3': rotav3,
          'pcv_1': pcv1,
          'pcv_2': pcv2,
          'pcv_3': pcv3,
        },
        cancelToken: cancelToken,
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
