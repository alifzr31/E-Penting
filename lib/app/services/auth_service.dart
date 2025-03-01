import 'package:dio/dio.dart';
import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class AuthService extends DioClient {
  Future<Response> login({String? username, String? password}) async {
    try {
      final response = await post(
        EndPoint.login,
        data: {'username': username, 'password': password},
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> logout() async {
    try {
      final response = await post(EndPoint.logout);

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }
}
