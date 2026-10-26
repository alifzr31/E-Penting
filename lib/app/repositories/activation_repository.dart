import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/services/activation_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class ActivationRepository {
  Future<Map<String, dynamic>?> checkParentNik({String? parentNik});
  Future<Map<String, dynamic>?> activateParentAccount({String? parentNik});
  void cancelAllRequests();
}

class ActivationRepositoryImpl implements ActivationRepository {
  final ActivationService _service;

  new(this._service);

  @override
  Future<Map<String, dynamic>?> checkParentNik({String? parentNik}) async {
    try {
      return await _service.checkParentNik(parentNik: parentNik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> activateParentAccount({
    String? parentNik,
  }) async {
    try {
      return await _service.activateParentAccount(parentNik: parentNik);
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
