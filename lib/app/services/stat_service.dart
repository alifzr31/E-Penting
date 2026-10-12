import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/percentage.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:flutter/foundation.dart';

class StatService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<List<Percentage>> fetchPercentage() async {
    final key = 'percentage';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/percentage',
        cancelToken: cancelToken,
      );

      return await compute(
        (message) =>
            message == null ? const [] : listPercentageFromJson(message),
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

  void cancelAllRequests() {
    DioHelper.removeAllCancelToken(_cancelTokens);
  }
}
