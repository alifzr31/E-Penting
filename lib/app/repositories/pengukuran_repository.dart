import 'package:dio/dio.dart';
import 'package:epenting/app/models/detail_pengukuran.dart';
import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/services/pengukuran_service.dart';

abstract class PengukuranRepository {
  Future<List<Pengukuran>> fetchAllPengukuran({
    int? page,
    int? month,
    int? year,
  });
  Future<List<Pengukuran>> fetchSearchPengukuran({String? name});
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
  });
  Future<DetailPengukuran?> fetchDetailPengukuran({int? idPengukuran});
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
  });
}

class PengukuranRepositoryImpl implements PengukuranRepository {
  final PengukuranService _service;

  PengukuranRepositoryImpl(this._service);

  @override
  Future<List<Pengukuran>> fetchAllPengukuran({
    int? page,
    int? month,
    int? year,
  }) async {
    return await _service.fetchAllPengukuran(
      page: page,
      month: month,
      year: year,
    );
  }

  @override
  Future<List<Pengukuran>> fetchSearchPengukuran({String? name}) async {
    return await _service.fetchSearchPengukuran(name: name);
  }

  @override
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
    return await _service.addPengukuran(
      tglPengukuran: tglPengukuran,
      idBalita: idBalita,
      caraPengukuran: caraPengukuran,
      beratBadan: beratBadan,
      tinggiBadan: tinggiBadan,
      lila: lila,
      lingkarKepala: lingkarKepala,
      selectedAsi: selectedAsi,
      pemberianVitA: pemberianVitA,
      jumlahPemberian: jumlahPemberian,
      pittingEdema: pittingEdema,
      derajat: derajat,
      kelasIbuBalita: kelasIbuBalita,
    );
  }

  @override
  Future<DetailPengukuran?> fetchDetailPengukuran({int? idPengukuran}) async {
    return await _service.fetchDetailPengukuran(idPengukuran: idPengukuran);
  }

  @override
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
    return await _service.editPengukuran(
      idPengukuran: idPengukuran,
      tglPengukuran: tglPengukuran,
      idBalita: idBalita,
      caraPengukuran: caraPengukuran,
      beratBadan: beratBadan,
      tinggiBadan: tinggiBadan,
      lila: lila,
      lingkarKepala: lingkarKepala,
      selectedAsi: selectedAsi,
      pemberianVitA: pemberianVitA,
      jumlahPemberian: jumlahPemberian,
      pittingEdema: pittingEdema,
      derajat: derajat,
      kelasIbuBalita: kelasIbuBalita,
    );
  }
}
