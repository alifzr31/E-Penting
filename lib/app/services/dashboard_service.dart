import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/models/percentage.dart';
import 'package:epenting/app/utils/end_point.dart';
import 'package:flutter/foundation.dart';

class DashboardService extends DioClient {
  Future<List<Percentage>> fetchPercentage() async {
    try {
      final response = await get(EndPoint.percentage);

      return response.data['data'] == null
          ? const []
          : await compute(
            (message) => listPercentageFromJson(message),
            response.data['data'],
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Balita>> fetchLatestBalita() async {
    try {
      final response = await get(EndPoint.latestBalita);

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

  Future<List<Pengukuran>> fetchLatestPengukuran() async {
    try {
      final response = await get(EndPoint.latestPengukuran);

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

  Future<List<Imunisasi>> fetchLatestImunisasi() async {
    try {
      final response = await get(EndPoint.latestImunisasi);

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
