import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class StatusGiziService extends DioClient {
  Future<String?> fetchClassification({
    int? age,
    double? height,
    String? gender,
    String? measure,
  }) async {
    try {
      final response = await get(
        EndPoint.classification,
        queryParams: {
          'umur_bulan': age,
          'tinggi': height,
          'jenis_kelamin': gender,
          'cara_ukur': measure,
        },
      );

      return await compute((message) => message, response.data['keterangan']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> fetchWeight({
    int? age,
    String? gender,
    double? weight,
  }) async {
    try {
      final response = await get(
        EndPoint.weight,
        queryParams: {
          'umur_bulan': age,
          'jenis_kelamin': gender,
          'berat': weight,
        },
      );

      return await compute((message) => message, response.data['keterangan']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> fetchNutrition({
    int? age,
    double? height,
    double? weight,
    String? gender,
    String? measure,
  }) async {
    try {
      final response = await get(
        EndPoint.nutrition,
        queryParams: {
          'umur_bulan': age,
          'tinggi': height,
          'berat': weight,
          'jenis_kelamin': gender,
          'cara_ukur': measure,
        },
      );

      return await compute((message) => message, response.data['keterangan']);
    } catch (e) {
      rethrow;
    }
  }
}
