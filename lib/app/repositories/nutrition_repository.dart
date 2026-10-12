import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/services/nutrition_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class NutritionRepository {
  Future<String?> fetchClassification({
    String? monthAge,
    String? tall,
    String? measureType,
    String? gender,
  });
  Future<String?> fetchWeight({
    String? monthAge,
    String? gender,
    String? weight,
  });
  Future<String?> fetchNutrition({
    String? monthAge,
    String? tall,
    String? weight,
    String? gender,
    String? measureType,
  });
  void cancelAllRequests();
}

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionService _service;

  new(this._service);

  @override
  Future<String?> fetchClassification({
    String? monthAge,
    String? tall,
    String? measureType,
    String? gender,
  }) async {
    try {
      return await _service.fetchClassification(
        monthAge: monthAge,
        tall: tall,
        measureType: measureType,
        gender: gender,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<String?> fetchWeight({
    String? monthAge,
    String? gender,
    String? weight,
  }) async {
    try {
      return await _service.fetchWeight(
        monthAge: monthAge,
        gender: gender,
        weight: weight,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<String?> fetchNutrition({
    String? monthAge,
    String? tall,
    String? weight,
    String? gender,
    String? measureType,
  }) async {
    try {
      return await _service.fetchNutrition(
        monthAge: monthAge,
        tall: tall,
        weight: weight,
        gender: gender,
        measureType: measureType,
      );
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
