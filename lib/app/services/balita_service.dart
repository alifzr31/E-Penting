import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class BalitaService extends DioClient {
  Future<List<Balita>> fetchAllBalita({int? page, String? ageFilter}) async {
    try {
      final response = await get(
        EndPoint.allBalita,
        queryParams: {
          'page': page,
          if (ageFilter != 'all') 'sorting': ageFilter,
        },
      );

      return response.data['data'] == null
          ? const []
          : await compute(
            (message) => listBalitaFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Balita>> fetchSearchBalita({String? name}) async {
    try {
      final response = await get(
        EndPoint.searchBalita,
        queryParams: {'name': name},
      );

      return response.data['data'] == null
          ? const []
          : await compute(
            (message) => listBalitaFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }
}
