import 'package:epenting/app/configs/dio/dio_client.dart';
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
}
