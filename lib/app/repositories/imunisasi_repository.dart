import 'package:dio/dio.dart';
import 'package:epenting/app/models/detail_imunisasi.dart';
import 'package:epenting/app/models/imunisasi.dart';
import 'package:epenting/app/services/imunisasi_service.dart';

abstract class ImunisasiRepository {
  Future<List<Imunisasi>> fetchAllImunisasi({int? page, int? month, int? year});
  Future<List<Imunisasi>> fetchSearchImunisasi({String? name});
  Future<Response> addImunisasi({
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  });
  Future<DetailImunisasi?> fetchDetailImunisasi({int? idImunisasi});
  Future<Response> editImunisasi({
    int? idImunisasi,
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  });
}

class ImunisasiRepositoryImpl implements ImunisasiRepository {
  final ImunisasiService _service;

  ImunisasiRepositoryImpl(this._service);

  @override
  Future<List<Imunisasi>> fetchAllImunisasi({
    int? page,
    int? month,
    int? year,
  }) async {
    return await _service.fetchAllImunisasi(
      page: page,
      month: month,
      year: year,
    );
  }

  @override
  Future<List<Imunisasi>> fetchSearchImunisasi({String? name}) async {
    return await _service.fetchSearchImunisasi(name: name);
  }

  @override
  Future<Response> addImunisasi({
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    return await _service.addImunisasi(
      idBalita: idBalita,
      tglImunisasi: tglImunisasi,
      selectedVaccine: selectedVaccine,
    );
  }

  @override
  Future<DetailImunisasi?> fetchDetailImunisasi({int? idImunisasi}) async {
    return await _service.fetchDetailImunisasi(idImunisasi: idImunisasi);
  }

  @override
  Future<Response> editImunisasi({
    int? idImunisasi,
    int? idBalita,
    String? tglImunisasi,
    List<String>? selectedVaccine,
  }) async {
    return await _service.editImunisasi(
      idImunisasi: idImunisasi,
      idBalita: idBalita,
      tglImunisasi: tglImunisasi,
      selectedVaccine: selectedVaccine,
    );
  }
}
