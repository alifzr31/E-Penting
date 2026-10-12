import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/percentage.dart';
import 'package:e_penting/app/services/stat_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class StatRepository {
  Future<List<Percentage>> fetchPercentage();
  void cancelAllRequests();
}

class StatRepositoryImpl implements StatRepository {
  final StatService _service;

  new(this._service);

  @override
  Future<List<Percentage>> fetchPercentage() async {
    try {
      return await _service.fetchPercentage();
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  void cancelAllRequests() async {
    return _service.cancelAllRequests();
  }
}
