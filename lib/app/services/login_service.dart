import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

class LoginService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<Map<String, dynamic>?> login({
    String? username,
    String? password,
  }) async {
    final key = 'login';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/login',
        data: {'username': ?username, 'password': ?password},
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
