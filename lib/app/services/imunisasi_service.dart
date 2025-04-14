import 'package:dio/dio.dart';
import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/detail_imunisasi.dart';
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

  Future<Response> addImunisasi({
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    try {
      final response = await post(
        EndPoint.addImunisasi,
        data: {
          'id_identitas': idBalita,
          'tanggal_imunisasi': tglImunisasi,
          'hb': selectedVaccine?.contains('hb'),
          'dpt_hb1': selectedVaccine?.contains('dpt_hb1'),
          'dpt_hb2': selectedVaccine?.contains('dpt_hb2'),
          'dpt_hb3': selectedVaccine?.contains('dpt_hb3'),
          'dpt_hbl': selectedVaccine?.contains('dpt_hbl'),
          'polio1': selectedVaccine?.contains('polio1'),
          'polio2': selectedVaccine?.contains('polio2'),
          'polio3': selectedVaccine?.contains('polio3'),
          'polio4': selectedVaccine?.contains('polio4'),
          'campak': selectedVaccine?.contains('campak'),
          'campak_l': selectedVaccine?.contains('campak_l'),
          'bcg': selectedVaccine?.contains('bcg'),
          'ipv_1': selectedVaccine?.contains('ipv_1'),
          'ipv_2': selectedVaccine?.contains('ipv_2'),
          'rotav_1': selectedVaccine?.contains('rotav_1'),
          'rotav_2': selectedVaccine?.contains('rotav_2'),
          'rotav_3': selectedVaccine?.contains('rotav_3'),
          'pcv_1': selectedVaccine?.contains('pcv_1'),
          'pcv_2': selectedVaccine?.contains('pcv_2'),
          'pcv_3': selectedVaccine?.contains('pcv_3'),
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailImunisasi?> fetchDetailImunisasi({int? idImunisasi}) async {
    try {
      final response = await get(
        EndPoint.detailImunisasi,
        queryParams: {'id_imunisasi': idImunisasi},
      );

      return await compute(
        (message) => detailImunisasiFromJson(message),
        response.data['data'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editImunisasi({
    int? idImunisasi,
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    try {
      final response = await patch(
        EndPoint.editImunisasi,
        queryParams: {'id_imunisasi': idImunisasi},
        data: {
          'id_identitas': idBalita,
          'tanggal_imunisasi': tglImunisasi,
          'hb': selectedVaccine?.contains('hb'),
          'dpt_hb1': selectedVaccine?.contains('dpt_hb1'),
          'dpt_hb2': selectedVaccine?.contains('dpt_hb2'),
          'dpt_hb3': selectedVaccine?.contains('dpt_hb3'),
          'dpt_hbl': selectedVaccine?.contains('dpt_hbl'),
          'polio1': selectedVaccine?.contains('polio1'),
          'polio2': selectedVaccine?.contains('polio2'),
          'polio3': selectedVaccine?.contains('polio3'),
          'polio4': selectedVaccine?.contains('polio4'),
          'campak': selectedVaccine?.contains('campak'),
          'campak_l': selectedVaccine?.contains('campak_l'),
          'bcg': selectedVaccine?.contains('bcg'),
          'ipv_1': selectedVaccine?.contains('ipv_1'),
          'ipv_2': selectedVaccine?.contains('ipv_2'),
          'rotav_1': selectedVaccine?.contains('rotav_1'),
          'rotav_2': selectedVaccine?.contains('rotav_2'),
          'rotav_3': selectedVaccine?.contains('rotav_3'),
          'pcv_1': selectedVaccine?.contains('pcv_1'),
          'pcv_2': selectedVaccine?.contains('pcv_2'),
          'pcv_3': selectedVaccine?.contains('pcv_3'),
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }
}
