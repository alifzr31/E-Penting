import 'package:dio/dio.dart';
import 'package:epenting/app/services/auth_service.dart';

abstract class AuthRepository {
  Future<Response> login({String? username, String? password});
  Future<Response> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<Response> login({String? username, String? password}) async {
    return await _service.login(username: username, password: password);
  }

  @override
  Future<Response> logout() async {
    return await _service.logout();
  }
}
