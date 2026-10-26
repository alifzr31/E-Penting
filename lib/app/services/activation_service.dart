import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:flutter/foundation.dart';

class ActivationService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<Map<String, dynamic>?> checkParentNik({String? parentNik}) async {
    final key = 'check_parent_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/orangtua/check',
        data: {'nik_orangtua': parentNik},
        cancelToken: cancelToken,
      );

      return await compute((message) => message, response.data);
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<Map<String, dynamic>?> activateParentAccount({
    String? parentNik,
  }) async {
    final key = 'activate_parent_account';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/orangtua/activate',
        data: {'nik_orangtua': parentNik},
        cancelToken: cancelToken,
      );

      return await compute((message) => message, response.data);
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
