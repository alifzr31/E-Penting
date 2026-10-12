import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_penting/app/configs/dio/interceptors.dart';
import 'package:e_penting/app/configs/firebase/firebase_remote.dart';
import 'package:e_penting/app/utils/app_env.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio _dio;
  final FirebaseRemote _firebaseRemote;

  new(this._firebaseRemote) {
    configureDio();
  }

  void configureDio() {
    _dio = Dio();

    // BASE API URL ENV
    _dio.options.baseUrl = AppEnv.baseApiUrl;
    // BASE API URL REMOTE CONFIG
    // _dio.options.baseUrl = _firebaseRemote.baseApiUrl;
    _dio.options.connectTimeout = const Duration(minutes: 3);
    _dio.options.receiveTimeout = const Duration(minutes: 3);
    _dio.options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.connectionTimeout = const Duration(seconds: 10);

        return client;
      },
      validateCertificate: (X509Certificate? cert, String host, int port) {
        // BASE API URL ENV
        final sslPinningActived = _firebaseRemote.sslPinningActived;

        if (kDebugMode || !sslPinningActived) return true;

        final validHost = Uri.parse(AppEnv.baseUrl).host;

        if (host != validHost) {
          return false;
        }

        if (cert == null) return false;

        final pinnedFingerprints = [AppEnv.ePentingSignature];

        final certBytes = cert.der;
        final digest = sha256.convert(certBytes);
        final serverFingerprint = digest.bytes
            .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
            .join(':');

        return pinnedFingerprints.contains(serverFingerprint);

        // BASE API URL REMOTE CONFIG
        // final baseApiUrl = _firebaseRemote.baseApiUrl;
        // final validHost = Uri.parse(baseApiUrl).host;

        // if (host != validHost) return false;

        // return true;
      },
    );
    _dio.interceptors.addAll([
      DioInterceptors(),
      if (kDebugMode) ...{
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      },
    ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> download(
    String urlPath,
    String savedPath, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    void Function(int count, int total)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savedPath,
        queryParameters: queryParams,
        options: Options(headers: headers),
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }
}
