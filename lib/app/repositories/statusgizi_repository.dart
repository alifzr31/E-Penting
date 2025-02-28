import 'package:epenting/app/services/statusgizi_service.dart';

abstract class StatusGiziRepository {
  Future<String?> fetchClassification({
    int? age,
    double? height,
    String? gender,
    String? measure,
  });
  Future<String?> fetchWeight({int? age, String? gender, double? weight});
  Future<String?> fetchNutrition({
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? measure,
  });
}

class StatusGiziRepositoryImpl implements StatusGiziRepository {
  final StatusGiziService _service;

  StatusGiziRepositoryImpl(this._service);

  @override
  Future<String?> fetchClassification({
    int? age,
    double? height,
    String? gender,
    String? measure,
  }) async {
    return await _service.fetchClassification(
      age: age,
      height: height,
      gender: gender,
      measure: measure,
    );
  }

  @override
  Future<String?> fetchWeight({
    int? age,
    String? gender,
    double? weight,
  }) async {
    return await _service.fetchWeight(age: age, gender: gender, weight: weight);
  }

  @override
  Future<String?> fetchNutrition({
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? measure,
  }) async {
    return await _service.fetchNutrition(
      age: age,
      height: height,
      weight: weight,
      gender: gender,
      measure: measure,
    );
  }
}
