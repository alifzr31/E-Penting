// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/get_it/service_locator.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart';

class DioInterceptors extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // print('ERROR STATUS CODE: ${err.response?.statusCode}');
    // print('ERROR STATUS DATA: ${err.response?.data}');

    if (err.error is SocketException) {
      return handler.next(err);
    } else {
      switch (err.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return handler.next(err);
        case DioExceptionType.badResponse:
          switch (err.response?.statusCode) {
            case 400:
              return handler.next(err);
            case 401:
              return handler.next(err);
            case 404:
              return handler.next(err);
            case 409:
              return handler.next(err);
            case 500:
              return handler.next(err);
          }
          break;
        case DioExceptionType.badCertificate:
          return handler.next(err);
        case DioExceptionType.unknown:
          return handler.next(err);
        case DioExceptionType.cancel:
          return handler.next(err);
        default:
          return handler.next(err);
      }
    }

    return handler.next(err);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = sl<AuthCubit>().accessToken;

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // print("<-- ${response.statusCode} ${response.requestOptions.uri}");
    // print("Headers: {${response.headers}}");
    // print("Response: ${response.data}");

    handler.next(response);
  }
}
