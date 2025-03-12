import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class ImunisasiService extends DioClient {
  Future<List<Imunisasi>> fetchAllImunisasi({
    int? page,
    int? month,
    int? year,
  }) async {
    try {
      final response = await get(
        EndPoint.allImunisasi,
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
            (message) => listImunisasiFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Imunisasi>> fetchSearchImunisasi({String? name}) async {
    try {
      final response = await get(
        EndPoint.searchImunisasi,
        queryParams: {'name': name},
      );

      return response.data['data'] == null
          ? const []
          : await compute(
            (message) => listImunisasiFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }
}
