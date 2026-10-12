import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/services/login_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class LoginRepository {
  Future<Map<String, dynamic>?> login({String? username, String? password});
  void cancelAllRequests();
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginService _service;

  new(this._service);

  @override
  Future<Map<String, dynamic>?> login({
    String? username,
    String? password,
  }) async {
    try {
      return await _service.login(username: username, password: password);
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
