import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/history_pengukuran.dart';
import 'package:epenting/app/models/latest_pengukuran.dart';
import 'package:epenting/app/models/latest_vaccine.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class OrtuService extends DioClient {
  Future<LatestPengukuran?> fetchLatestPengukuranBalita({String? nik}) async {
    try {
      final response = await get(
        EndPoint.latestPengukuranBalita,
        queryParams: {'nik': nik},
      );

      return await compute(
        (message) => latestPengukuranFromJson(message),
        response.data['data']['pengukuran'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LatestVaccine>> fetchLatestVaccine({String? nik}) async {
    try {
      final response = await get(
        EndPoint.latestVaccine,
        queryParams: {'nik': nik},
      );

      return response.data['data']['list_imunisasi'] == null
          ? const []
          : await compute(
            (message) => listLatestVaccineFromJson(message),
            response.data['data']['list_imunisasi'],
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<HistoryPengukuran>> fetchHistoryPengukuran({String? nik}) async {
    try {
      final response = await get(
        EndPoint.historyPengukuran,
        queryParams: {'nik': nik},
      );

      return response.data['data']['pengukuran'] == null
          ? const []
          : await compute(
            (message) => listHistoryPengukuranFromJson(message),
            response.data['data']['pengukuran'],
          );
    } catch (e) {
      rethrow;
    }
  }
}
