import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class PengukuranService extends DioClient {
  Future<List<Pengukuran>> fetchAllPengukuran({
    int? page,
    int? month,
    int? year,
  }) async {
    try {
      final response = await get(
        EndPoint.allPengukuran,
        queryParams: {
          'page': page,
          if (month != null) ...{
            'month': month > 9 ? month.toString() : '0$month',
          },
          if (year != null) 'year': year,
        },
      );

      return response.data['data'] == null
          ? const []
          : await compute(
            (message) => listPengukuranFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }
}
