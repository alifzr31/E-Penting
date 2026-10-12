import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:flutter/foundation.dart';

class NutritionService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<String?> fetchClassification({
    String? monthAge,
    String? tall,
    String? measureType,
    String? gender,
  }) async {
    final key = 'classification';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/classification',
        queryParams: {
          'umur_bulan': monthAge,
          'tinggi': tall,
          'cara_ukur': measureType,
          'jenis_kelamin': gender,
        },
        cancelToken: cancelToken,
      );

      return await compute((message) => message, response.data['keterangan']);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<String?> fetchWeight({
    String? monthAge,
    String? gender,
    String? weight,
  }) async {
    final key = 'weight';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/berat-badan',
        queryParams: {
          'umur_bulan': monthAge,
          'jenis_kelamin': gender,
          'berat': weight,
        },
        cancelToken: cancelToken,
      );

      return await compute((message) => message, response.data['keterangan']);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<String?> fetchNutrition({
    String? monthAge,
    String? tall,
    String? weight,
    String? gender,
    String? measureType,
  }) async {
    final key = 'nutrition';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/gizi',
        queryParams: {
          'umur_bulan': monthAge,
          'tinggi': tall,
          'berat': weight,
          'jenis_kelamin': gender,
          'cara_ukur': measureType,
        },
        cancelToken: cancelToken,
      );

      return await compute((message) => message, response.data['keterangan']);
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
