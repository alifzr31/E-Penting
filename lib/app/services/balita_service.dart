import 'package:dio/dio.dart';
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

  Future<String> checkNikBalita({String? nik}) async {
    try {
      final response = await post(EndPoint.checkNikBalita, data: {'nik': nik});

      return await compute((message) => message, response.data['message']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addBalita({
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  }) async {
    try {
      final response = await post(
        EndPoint.addBalita,
        data: {
          'nik_anak': nik,
          'nomor_kk': noKk,
          'nama_anak': namaBalita,
          'tanggal_lahir': tglLahir,
          'jenis_kelamin': jenisKelamin,
          'anak_ke': anakKe,
          'berat_lahir': beratLahir,
          'tinggi': tinggiLahir,
          'lingkar_kepala_lahir': lingkarKepalaLahir,
          'usia_kehamilan': usiaKehamilan,
          'kia_bayi_kecil': kiaBayiKecil == 'ya' ? true : false,
          'kia': bukuKia == 'ya' ? 1 : 0,
          'imd': imd == 'ya' ? 1 : 0,
          'nik_ortu': nikOrtu,
          'nama_ortu': namaOrtu,
          'nomor_telepon': noTelp,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'penduduk_kota_bandung': pendudukBandung == 'ya' ? 1 : 0,
          'kecamatan': idKecamatan,
          'kelurahan': idKelurahan,
          'puskesmas': idPuskesmas,
          'posyandu': idPosyandu,
          'provinsi': 'Jawa Barat',
          'kota': 'Bandung',
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> pindahBalita({
    int? idBalita,
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  }) async {
    try {
      final response = await patch(
        EndPoint.pindahBalita,
        queryParams: {'id_identitas': idBalita},
        data: {
          'nik_anak': nik,
          'nomor_kk': noKk,
          'nama_anak': namaBalita,
          'tanggal_lahir': tglLahir,
          'jenis_kelamin': jenisKelamin,
          'anak_ke': anakKe,
          'berat_lahir': beratLahir,
          'tinggi': tinggiLahir,
          'lingkar_kepala_lahir': lingkarKepalaLahir,
          'usia_kehamilan': usiaKehamilan,
          'kia_bayi_kecil': kiaBayiKecil == 'ya' ? true : false,
          'kia': bukuKia == 'ya' ? 1 : 0,
          'imd': imd == 'ya' ? 1 : 0,
          'nik_ortu': nikOrtu,
          'nama_ortu': namaOrtu,
          'nomor_telepon': noTelp,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'penduduk_kota_bandung': pendudukBandung == 'ya' ? 1 : 0,
          'kecamatan': idKecamatan,
          'kelurahan': idKelurahan,
          'puskesmas': idPuskesmas,
          'posyandu': idPosyandu,
          'provinsi': 'Jawa Barat',
          'kota': 'Bandung',
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Balita>> fetchSearchPindahBalita({String? name}) async {
    try {
      final response = await get(
        EndPoint.searchPindahBalita,
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

  Future<Balita?> fetchDetailBalita({int? balitaId}) async {
    try {
      final response = await get(
        EndPoint.detailBalita,
        queryParams: {'id': balitaId},
      );

      return response.data['data'] == null
          ? null
          : await compute(
            (message) => balitaFromJson(message),
            response.data['data'].first,
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateBalita({
    int? balitaId,
    String? nikAnak,
    String? noKk,
    String? namaAnak,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepala,
    String? usiaKehamilan,
    bool? kiaBayiKecil,
    int? bukuKia,
    int? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelpOrtu,
    String? alamat,
    String? rt,
    String? rw,
    int? pendudukBandung,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
  }) async {
    try {
      final response = await patch(
        EndPoint.updateBalita,
        queryParams: {'id': balitaId},
        data: {
          'nik_anak': nikAnak,
          'nomor_kk': noKk,
          'nama_anak': namaAnak,
          'tanggal_lahir': tglLahir,
          'jenis_kelamin': jenisKelamin,
          'anak_ke': anakKe,
          'berat_lahir': beratLahir,
          'tinggi': tinggiLahir,
          'lingkar_kepala_lahir': lingkarKepala,
          'usia_kehamilan': usiaKehamilan,
          'kia_bayi_kecil': kiaBayiKecil,
          'kia': bukuKia,
          'imd': imd,
          'nik_ortu': nikOrtu,
          'nama_ortu': namaOrtu,
          'nomor_telepon': noTelpOrtu,
          'alamat': alamat,
          'rt': rt,
          'rw': rw,
          'provinsi': 'Jawa Barat',
          'kota': 'Bandung',
          'penduduk_kota_bandung': pendudukBandung,
          'kecamatan': idKecamatan,
          'kelurahan': idKelurahan,
          'puskesmas': idPuskesmas,
          'posyandu': idPosyandu,
        },
      );

      return await compute((message) => message, response);
    } catch (e) {
      rethrow;
    }
  }
}
