import 'package:epenting/app/models/pengukuran.dart';
import 'package:epenting/app/services/pengukuran_service.dart';

abstract class PengukuranRepository {
  Future<List<Pengukuran>> fetchAllPengukuran({
    int? page,
    int? month,
    int? year,
  });
  Future<List<Pengukuran>> fetchSearchPengukuran({String? name});
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
}
