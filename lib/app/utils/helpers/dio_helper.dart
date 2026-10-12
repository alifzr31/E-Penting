import 'package:dio/dio.dart' show CancelToken, DioException, DioExceptionType;
import 'package:e_penting/app/utils/consts/app_strings.dart';

class DioHelper {
  static CancelToken createCancelToken(
    Map<String, CancelToken> cancelTokens, {
    required String key,
  }) {
    if (cancelTokens.containsKey(key)) {
      cancelTokens[key]?.cancel();
    }

    final cancelToken = CancelToken();
    cancelTokens[key] = cancelToken;

    return cancelToken;
  }

  static void removeCancelToken(
    Map<String, CancelToken> cancelTokens, {
    required String key,
  }) {
    cancelTokens[key]?.cancel();
    cancelTokens.remove(key);
  }

  static void removeAllCancelToken(Map<String, CancelToken> cancelTokens) {
    for (final cancelToken in cancelTokens.values) {
      cancelToken.cancel();
    }

    cancelTokens.clear();
  }

  static String errorHandlingApiMessage(Object e) {
    if (e is! DioException) {
      return AppStrings.unknownErrorApiMessage;
    }

    final type = e.type;
    final statusCode = e.response?.statusCode;

    if (type == DioExceptionType.connectionError) {
      return AppStrings.noConnectionErrorApiMessage;
    }

    if (statusCode == null) {
      return AppStrings.unknownErrorApiMessage;
    }

    if (statusCode >= 500) {
      return AppStrings.serverErrorApiMessage;
    }

    final data = e.response?.data;

    if (data is Map) {
      final rawMessage = data['message'];

      if (rawMessage is String && rawMessage.isNotEmpty) {
        return rawMessage;
      }
    }

    return AppStrings.unknownErrorApiMessage;
  }
}
