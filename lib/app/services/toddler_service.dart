import 'package:dio/dio.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/models/toddler_latest_nik.dart';
import 'package:e_penting/app/utils/extensions/date_time_extension.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';
import 'package:flutter/foundation.dart';

class ToddlerService {
  final DioClient _dioClient;

  new(this._dioClient);

  final Map<String, CancelToken> _cancelTokens = {};

  Future<ToddlerLatestNik?> fetchToodlerLatestNik({String? nik}) async {
    final key = 'toddler_latest_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/latest-nik',
        queryParams: {'nik': nik},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => toddlerLatestNikFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Toddler>> fetchLatestToddlers() async {
    final key = 'latest_toddler';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/latest',
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null ? [] : listToddlerFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Toddler>> fetchToddlers({
    int? page,
    String? rangeMonthAge,
  }) async {
    final key = 'toddlers';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/list',
        queryParams: {
          'page': page,
          if (rangeMonthAge != null && rangeMonthAge != 'all') ...{
            'sorting': rangeMonthAge,
          },
        },
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null ? [] : listToddlerFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Toddler>> fetchSearchToddlers({String? keyword}) async {
    final key = 'search_toddlers';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/search',
        queryParams: {'name': ?keyword},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null ? [] : listToddlerFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<Toddler?> fetchDetailToddler({int? id}) async {
    final key = 'detail_toddler';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/detail',
        queryParams: {'id': ?id},
        cancelToken: cancelToken,
      );

      return await compute(
        (message) => message == null ? null : toddlerFromJson(message),
        response.data['data'].first,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<List<Toddler>> fetchSearchMoveToddler({String? keyword}) async {
    final key = 'search_move_toddler';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.get(
        '/balita/pindah/search',
        cancelToken: cancelToken,
        queryParams: {'name': keyword},
      );

      return await compute(
        (message) => message == null ? const [] : listToddlerFromJson(message),
        response.data['data'],
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<Map<String, dynamic>?> checkToddlerNik({String? nik}) async {
    final key = 'check_toddler_nik';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.post(
        '/balita/cek-nik',
        data: {'nik': nik},
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<Map<String, dynamic>?> createToddler({
    required bool newToddler,
    String? toddlerNik,
    String? toddlerNoKk,
    int? toddlerId,
    String? toddlerName,
    DateTime? toddlerBornDate,
    String? toddlerGender,
    String? toddlerNumber,
    String? toddlerWeight,
    String? toddlerHeight,
    String? toddlerHeadCircumference,
    String? gestationalAge,
    bool? kiaBayiKecil,
    int? hasKiaBook,
    int? imd,
    String? parentNik,
    String? parentName,
    String? parentPhoneNumber,
    String? address,
    String? rt,
    String? rw,
    int? isBandungResident,
    int? districtId,
    int? subDistrictId,
    int? healthFacilityId,
    int? healthPostId,
  }) async {
    final key = 'create_toddler';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = newToddler
          ? await _dioClient.post(
              '/balita/create',
              cancelToken: cancelToken,
              data: {
                'nik_anak': toddlerNik,
                'nomor_kk': toddlerNoKk,
                'nama_anak': toddlerName,
                'tanggal_lahir': toddlerBornDate?.formDataFormat(),
                'jenis_kelamin': toddlerGender,
                'anak_ke': toddlerNumber,
                'berat_lahir': toddlerWeight,
                'tinggi': toddlerHeight,
                'lingkar_kepala_lahir': toddlerHeadCircumference,
                'usia_kehamilan': gestationalAge,
                'kia_bayi_kecil': kiaBayiKecil,
                'kia': hasKiaBook,
                'imd': imd,
                'nik_ortu': parentNik,
                'nama_ortu': parentName,
                'nomor_telepon': parentPhoneNumber,
                'alamat': address,
                'rt': rt,
                'rw': rw,
                'penduduk_kota_bandung': isBandungResident,
                'kecamatan': districtId,
                'kelurahan': subDistrictId,
                'puskesmas': healthFacilityId,
                'posyandu': healthPostId,
                'provinsi': 'Jawa Barat',
                'kota': 'Bandung',
              },
            )
          : await _dioClient.patch(
              '/balita/pindah',
              cancelToken: cancelToken,
              queryParams: {'id_identitas': toddlerId},
            );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  Future<Map<String, dynamic>?> editToddler({
    int? toddlerId,
    String? toddlerNik,
    String? toddlerNoKk,
    String? toddlerName,
    DateTime? toddlerBornDate,
    String? toddlerGender,
    String? toddlerNumber,
    String? toddlerWeight,
    String? toddlerHeight,
    String? toddlerHeadCircumference,
    String? gestationalAge,
    bool? kiaBayiKecil,
    int? hasKiaBook,
    int? imd,
    String? parentNik,
    String? parentName,
    String? parentPhoneNumber,
    String? address,
    String? rt,
    String? rw,
    int? isBandungResident,
    int? districtId,
    int? subDistrictId,
    int? healthFacilityId,
    int? healthPostId,
  }) async {
    final key = 'edit_toddler';
    final cancelToken = DioHelper.createCancelToken(_cancelTokens, key: key);

    try {
      final response = await _dioClient.patch(
        '/balita',
        cancelToken: cancelToken,
        queryParams: {'id': toddlerId},
        data: {
          'nik_anak': toddlerNik,
          'nomor_kk': toddlerNoKk,
          'nama_anak': toddlerName,
          'tanggal_lahir': toddlerBornDate?.formDataFormat(),
          'jenis_kelamin': toddlerGender,
          'anak_ke': toddlerNumber,
          'berat_lahir': toddlerWeight,
          'tinggi': toddlerHeight,
          'lingkar_kepala_lahir': toddlerHeadCircumference,
          'usia_kehamilan': gestationalAge,
          'kia_bayi_kecil': kiaBayiKecil,
          'kia': hasKiaBook,
          'imd': imd,
          'nik_ortu': parentNik,
          'nama_ortu': parentName,
          'nomor_telepon': parentPhoneNumber,
          'alamat': address,
          'rt': rt,
          'rw': rw,
          'penduduk_kota_bandung': isBandungResident,
          'kecamatan': districtId,
          'kelurahan': subDistrictId,
          'puskesmas': healthFacilityId,
          'posyandu': healthPostId,
          'provinsi': 'Jawa Barat',
          'kota': 'Bandung',
        },
      );

      return response.data;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw RequestCancelledException();
      }

      rethrow;
    } finally {
      DioHelper.removeCancelToken(_cancelTokens, key: key);
    }
  }

  void cancelAllRequests() {
    DioHelper.removeAllCancelToken(_cancelTokens);
  }
}
