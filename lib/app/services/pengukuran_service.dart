import 'package:dio/dio.dart';
import 'package:epenting/app/configs/dio/dio_client.dart';
import 'package:epenting/app/models/detail_pengukuran.dart';
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

  Future<List<Pengukuran>> fetchSearchPengukuran({String? name}) async {
    try {
      final response = await get(
        EndPoint.searchPengukuran,
        queryParams: {'name': name},
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

  Future<Response> addPengukuran({
    String? tglPengukuran,
    int? idBalita,
    String? caraPengukuran,
    String? beratBadan,
    String? tinggiBadan,
    String? lila,
    String? lingkarKepala,
    List<String>? selectedAsi,
    String? pemberianVitA,
    String? jumlahPemberian,
    String? pittingEdema,
    int? derajat,
    String? kelasIbuBalita,
  }) async {
    try {
      final response = await post(
        EndPoint.addPengukuran,
        data: {
          'tanggal_ukur': tglPengukuran,
          'id_identitas': idBalita,
          'cara_ukur': caraPengukuran,
          'berat': beratBadan,
          'tinggi': tinggiBadan,
          if (lila?.isNotEmpty ?? false) 'lila': lila,
          if (lila?.isNotEmpty ?? false) 'lingkar_kepala': lingkarKepala,
          'asi_bulan_0':
              (selectedAsi?.contains('bulan0') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_1':
              (selectedAsi?.contains('bulan1') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_2':
              (selectedAsi?.contains('bulan2') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_3':
              (selectedAsi?.contains('bulan3') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_4':
              (selectedAsi?.contains('bulan4') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_5':
              (selectedAsi?.contains('bulan5') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_6':
              (selectedAsi?.contains('bulan6') ?? false) ? 'ya' : 'tidak',
          'vitamin_a': pemberianVitA,
          'pemberian_ke':
              (jumlahPemberian?.isEmpty ?? false) ? 0 : jumlahPemberian,
          'pitting_edema': pittingEdema == 'ya' ? derajat : 4,
          'kelas_ibu_balita': kelasIbuBalita == 'ya' ? true : false,
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailPengukuran?> fetchDetailPengukuran({int? idPengukuran}) async {
    try {
      final response = await get(
        EndPoint.detailPengukuran,
        queryParams: {'id_penimbangan': idPengukuran},
      );

      return await compute(
        (message) => detailPengukuranFromJson(message),
        response.data['data'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editPengukuran({
    int? idPengukuran,
    String? tglPengukuran,
    int? idBalita,
    String? caraPengukuran,
    String? beratBadan,
    String? tinggiBadan,
    String? lila,
    String? lingkarKepala,
    List<String>? selectedAsi,
    String? pemberianVitA,
    String? jumlahPemberian,
    String? pittingEdema,
    int? derajat,
    String? kelasIbuBalita,
  }) async {
    try {
      final response = await patch(
        EndPoint.editPengukuran,
        queryParams: {'id_pengukuran': idPengukuran},
        data: {
          'tanggal_ukur': tglPengukuran,
          'id_identitas': idBalita,
          'cara_ukur': caraPengukuran,
          'berat': beratBadan,
          'tinggi': tinggiBadan,
          if (lila?.isNotEmpty ?? false) 'lila': lila,
          if (lila?.isNotEmpty ?? false) 'lingkar_kepala': lingkarKepala,
          'asi_bulan_0':
              (selectedAsi?.contains('bulan0') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_1':
              (selectedAsi?.contains('bulan1') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_2':
              (selectedAsi?.contains('bulan2') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_3':
              (selectedAsi?.contains('bulan3') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_4':
              (selectedAsi?.contains('bulan4') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_5':
              (selectedAsi?.contains('bulan5') ?? false) ? 'ya' : 'tidak',
          'asi_bulan_6':
              (selectedAsi?.contains('bulan6') ?? false) ? 'ya' : 'tidak',
          'vitamin_a': pemberianVitA,
          'pemberian_ke':
              (jumlahPemberian?.isEmpty ?? false) ? 0 : jumlahPemberian,
          'pitting_edema': pittingEdema == 'ya' ? derajat : 4,
          'kelas_ibu_balita': kelasIbuBalita == 'ya' ? true : false,
        },
      );

      return await compute((message) => response, response);
    } catch (e) {
      rethrow;
    }
  }
}
