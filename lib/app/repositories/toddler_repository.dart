import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/models/toddler_latest_nik.dart';
import 'package:e_penting/app/services/toddler_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class ToddlerRepository {
  Future<ToddlerLatestNik?> fetchToodlerLatestNik({String? nik});
  Future<List<Toddler>> fetchLatestToddlers();
  Future<List<Toddler>> fetchToddlers({int? page, String? rangeMonthAge});
  Future<List<Toddler>> fetchSearchToddlers({String? keyword});
  Future<Toddler?> fetchDetailToddler({int? id});
  Future<List<Toddler>> fetchSearchMoveToddler({String? keyword});
  Future<Map<String, dynamic>?> checkToddlerNik({String? nik});
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
  });
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
  });
  void cancelAllRequests();
}

class ToddlerRepositoryImpl implements ToddlerRepository {
  final ToddlerService _service;

  new(this._service);

  @override
  Future<ToddlerLatestNik?> fetchToodlerLatestNik({String? nik}) async {
    try {
      return await _service.fetchToodlerLatestNik(nik: nik);
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Toddler>> fetchLatestToddlers() async {
    try {
      return await _service.fetchLatestToddlers();
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Toddler>> fetchToddlers({
    int? page,
    String? rangeMonthAge,
  }) async {
    try {
      return await _service.fetchToddlers(
        page: page,
        rangeMonthAge: rangeMonthAge,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Toddler>> fetchSearchToddlers({String? keyword}) async {
    try {
      return await _service.fetchSearchToddlers(keyword: keyword);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Toddler?> fetchDetailToddler({int? id}) async {
    try {
      return await _service.fetchDetailToddler(id: id);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Toddler>> fetchSearchMoveToddler({String? keyword}) async {
    try {
      return await _service.fetchSearchMoveToddler(keyword: keyword);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> checkToddlerNik({String? nik}) async {
    try {
      return await _service.checkToddlerNik(nik: nik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
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
    try {
      return await _service.createToddler(
        newToddler: newToddler,
        toddlerNik: toddlerNik,
        toddlerNoKk: toddlerNoKk,
        toddlerId: toddlerId,
        toddlerName: toddlerName,
        toddlerBornDate: toddlerBornDate,
        toddlerGender: toddlerGender,
        toddlerNumber: toddlerNumber,
        toddlerWeight: toddlerWeight,
        toddlerHeight: toddlerHeight,
        toddlerHeadCircumference: toddlerHeadCircumference,
        gestationalAge: gestationalAge,
        kiaBayiKecil: kiaBayiKecil,
        hasKiaBook: hasKiaBook,
        imd: imd,
        parentNik: parentNik,
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        address: address,
        rt: rt,
        rw: rw,
        isBandungResident: isBandungResident,
        districtId: districtId,
        subDistrictId: subDistrictId,
        healthFacilityId: healthFacilityId,
        healthPostId: healthPostId,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
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
    try {
      return await _service.editToddler(
        toddlerId: toddlerId,
        toddlerNik: toddlerNik,
        toddlerNoKk: toddlerNoKk,
        toddlerName: toddlerName,
        toddlerBornDate: toddlerBornDate,
        toddlerGender: toddlerGender,
        toddlerNumber: toddlerNumber,
        toddlerWeight: toddlerWeight,
        toddlerHeight: toddlerHeight,
        toddlerHeadCircumference: toddlerHeadCircumference,
        gestationalAge: gestationalAge,
        kiaBayiKecil: kiaBayiKecil,
        hasKiaBook: hasKiaBook,
        imd: imd,
        parentNik: parentNik,
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        address: address,
        rt: rt,
        rw: rw,
        isBandungResident: isBandungResident,
        districtId: districtId,
        subDistrictId: subDistrictId,
        healthFacilityId: healthFacilityId,
        healthPostId: healthPostId,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  void cancelAllRequests() {
    return _service.cancelAllRequests();
  }
}
