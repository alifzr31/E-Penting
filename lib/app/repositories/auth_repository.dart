import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/profile.dart';
import 'package:e_penting/app/services/auth_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class AuthRepository {
  Future<Profile?> fetchProfile();
  Future<Map<String, dynamic>?> logout();
  void cancelAllRequests();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  new(this._service);

  @override
  Future<Profile?> fetchProfile() async {
    try {
      return await _service.fetchProfile();
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> logout() async {
    try {
      return await _service.logout();
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  void cancelAllRequests() {
    return _service.cancelAllRequests();
  }
}
