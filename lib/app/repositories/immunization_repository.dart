import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/immunization.dart';
import 'package:e_penting/app/models/immunization_detail.dart';
import 'package:e_penting/app/models/immunization_history_nik.dart';
import 'package:e_penting/app/services/immunization_service.dart';
import 'package:e_penting/app/utils/helpers/dio_helper.dart';

abstract class ImmunizationRepository {
  Future<List<ImmunizationHistoryNik>> fetchImmunizationHistoryNik({
    String? nik,
  });
  Future<List<Immunization>> fetchLatestImmunizations();
  Future<List<Immunization>> fetchImmunizations({
    int? page,
    int? month,
    int? year,
  });
  Future<List<Immunization>> fetchSearchImmunizations({String? keyword});
  Future<ImmunizationDetail?> fetchImmunizationDetail({int? immunizationId});
  Future<Map<String, dynamic>?> createImmunization({
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  });
  Future<Map<String, dynamic>?> editImmunization({
    int? immunizationId,
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  });
  void cancelAllRequests();
}

class ImmunizationRepositoryImpl implements ImmunizationRepository {
  final ImmunizationService _service;

  new(this._service);

  @override
  Future<List<ImmunizationHistoryNik>> fetchImmunizationHistoryNik({
    String? nik,
  }) async {
    try {
      return await _service.fetchImmunizationHistoryNik(nik: nik);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Immunization>> fetchLatestImmunizations() async {
    try {
      return await _service.fetchLatestImmunizations();
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Immunization>> fetchImmunizations({
    int? page,
    int? month,
    int? year,
  }) async {
    try {
      return await _service.fetchImmunizations(
        page: page,
        month: month,
        year: year,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<List<Immunization>> fetchSearchImmunizations({String? keyword}) async {
    try {
      return await _service.fetchSearchImmunizations(keyword: keyword);
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<ImmunizationDetail?> fetchImmunizationDetail({
    int? immunizationId,
  }) async {
    try {
      return await _service.fetchImmunizationDetail(
        immunizationId: immunizationId,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> createImmunization({
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  }) async {
    try {
      return await _service.createImmunization(
        toddlerId: toddlerId,
        immunizationDate: immunizationDate,
        hb: hb,
        dptHb1: dptHb1,
        dptHb2: dptHb2,
        dptHb3: dptHb3,
        dptHbl: dptHbl,
        polio1: polio1,
        polio2: polio2,
        polio3: polio3,
        polio4: polio4,
        campak: campak,
        campakL: campakL,
        bcg: bcg,
        ipv1: ipv1,
        ipv2: ipv2,
        rotav1: rotav1,
        rotav2: rotav2,
        rotav3: rotav3,
        pcv1: pcv1,
        pcv2: pcv2,
        pcv3: pcv3,
      );
    } on RequestCancelledException {
      rethrow;
    } catch (e) {
      final errorMessage = DioHelper.errorHandlingApiMessage(e);

      throw AppException(errorMessage);
    }
  }

  @override
  Future<Map<String, dynamic>?> editImmunization({
    int? immunizationId,
    int? toddlerId,
    DateTime? immunizationDate,
    bool? hb,
    bool? dptHb1,
    bool? dptHb2,
    bool? dptHb3,
    bool? dptHbl,
    bool? polio1,
    bool? polio2,
    bool? polio3,
    bool? polio4,
    bool? campak,
    bool? campakL,
    bool? bcg,
    bool? ipv1,
    bool? ipv2,
    bool? rotav1,
    bool? rotav2,
    bool? rotav3,
    bool? pcv1,
    bool? pcv2,
    bool? pcv3,
  }) async {
    try {
      return await _service.editImmunization(
        immunizationId: immunizationId,
        toddlerId: toddlerId,
        immunizationDate: immunizationDate,
        hb: hb,
        dptHb1: dptHb1,
        dptHb2: dptHb2,
        dptHb3: dptHb3,
        dptHbl: dptHbl,
        polio1: polio1,
        polio2: polio2,
        polio3: polio3,
        polio4: polio4,
        campak: campak,
        campakL: campakL,
        bcg: bcg,
        ipv1: ipv1,
        ipv2: ipv2,
        rotav1: rotav1,
        rotav2: rotav2,
        rotav3: rotav3,
        pcv1: pcv1,
        pcv2: pcv2,
        pcv3: pcv3,
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
